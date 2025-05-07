import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:rive/rive.dart' as rive;
import '../../../../../model/item_model.dart';

class ShadowMatch extends StatefulWidget {
  @override
  _ShadowMatchState createState() => _ShadowMatchState();
}

class _ShadowMatchState extends State<ShadowMatch>
    with SingleTickerProviderStateMixin {
  final player = AudioPlayer();
  late List<ItemModel> items;
  late List<ItemModel> reverseItem;
  late int score;
  late bool gameOver;
  late ConfettiController _confettiController;
  bool _isDragging = false;
  late AnimationController _titleAnimationController;
  late Animation<double> _titleAnimation;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );
    _titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _titleAnimation = CurvedAnimation(
      parent: _titleAnimationController,
      curve: Curves.elasticOut,
    );
    _titleAnimationController.forward();
    initGame();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _titleAnimationController.dispose();
    player.dispose();
    super.dispose();
  }

  void initGame() {
    setState(() {
      gameOver = false;
      score = 0;
      items = [
        ItemModel(
          value: 'lion',
          name: 'lion',
          img: 'assets/match_images/3.1.png',
          color: Colors.amber[300]!,
        ),
        ItemModel(
          value: 'peng',
          name: 'peng',
          img: 'assets/match_images/2.1.png',
          color: Colors.blue[200]!,
        ),
        ItemModel(
          value: 'fox',
          name: 'fox',
          img: 'assets/match_images/1.1.png',
          color: Colors.orange[300]!,
        ),
        ItemModel(
          value: 'goat',
          name: 'goat',
          img: 'assets/match_images/4.1.png',
          color: Colors.brown[200]!,
        ),
        ItemModel(
          value: 'jed',
          name: 'jed',
          img: 'assets/match_images/bondok.png',
          color: Colors.grey[300]!,
        ),
        ItemModel(
          value: 'cow',
          name: 'cow',
          img: 'assets/match_images/sen.png',
          color: Colors.black54,
        ),
        ItemModel(
          value: 'dog',
          name: 'dog',
          img: 'assets/match_images/skate.png',
          color: Colors.purple[200]!,
        ),
      ];

      reverseItem = [
        ItemModel(
          value: 'lion',
          name: 'lion',
          img: 'assets/match_images/3.2.png',
          color: Colors.amber[300]!,
        ),
        ItemModel(
          value: 'peng',
          name: 'peng',
          img: 'assets/match_images/2.2.png',
          color: Colors.blue[200]!,
        ),
        ItemModel(
          value: 'fox',
          name: 'fox',
          img: 'assets/match_images/1.2.png',
          color: Colors.orange[300]!,
        ),
        ItemModel(
          value: 'goat',
          name: 'goat',
          img: 'assets/match_images/4.2.png',
          color: Colors.brown[200]!,
        ),
        ItemModel(
          value: 'jed',
          name: 'jed',
          img: 'assets/match_images/bondok2.png',
          color: Colors.grey[300]!,
        ),
        ItemModel(
          value: 'cow',
          name: 'cow',
          img: 'assets/match_images/sen2.png',
          color: Colors.black54,
        ),
        ItemModel(
          value: 'dog',
          name: 'dog',
          img: 'assets/match_images/skate2.png',
          color: Colors.purple[200]!,
        ),
      ];

      items.shuffle();
      reverseItem.shuffle();
    });
  }

  Future<void> _playSound(String sound) async {
    await player.play(AssetSource(sound));
  }

  void _handleAccept(ItemModel item, ItemModel receivedItem) async {
    if (isAnimating) return;

    setState(() {
      isAnimating = true;
    });

    if (item.value == receivedItem.value) {
      await _playSound('true.mp3');
      setState(() {
        items.remove(receivedItem);
        reverseItem.remove(item);
        score += 10;
      });
    } else {
      await _playSound('false.mp3');
      setState(() {
        score = score > 0 ? score - 2 : 0;
      });
    }

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      isAnimating = false;
      item.accepting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      gameOver = true;
      if (score == 70) {
        _confettiController.play();
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade50, Colors.purple.shade50],
                ),
              ),
              child: CustomPaint(painter: _BubblePainter()),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // App Bar
                _buildAppBar(),

                // Game Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (!gameOver) _buildGameArea(),
                        if (gameOver) _buildGameOverScreen(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              createParticlePath: (size) {
                return Path()..addOval(
                  Rect.fromCircle(center: Offset.zero, radius: size.width / 2),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue.shade800, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          if (!gameOver)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade200, Colors.purple.shade200],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow.shade700),
                  SizedBox(width: 8),
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(width: 48), // For balance
        ],
      ),
    );
  }

  Widget _buildGameArea() {
    return Column(
      children: [
        SizedBox(height: 20),
        // Animated Title
        ScaleTransition(
          scale: _titleAnimation,
          child: Text(
            'Match the Shadows!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.white,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10),
        Text(
          'Drag the items to their matching shadows',
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),

        SizedBox(height: 30),
        // Game Board
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Draggable Items
                Expanded(
                  child: Column(
                    children:
                        items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Draggable<ItemModel>(
                              data: item,
                              onDragStarted: () {
                                setState(() {
                                  _isDragging = true;
                                });
                                _playSound('pickup.mp3');
                              },
                              onDragEnd: (_) {
                                setState(() {
                                  _isDragging = false;
                                });
                              },
                              childWhenDragging: Opacity(
                                opacity: 0.3,
                                child: _buildItemCard(item),
                              ),
                              feedback: Transform.scale(
                                scale: 1.2,
                                child: Material(
                                  elevation: 8,
                                  borderRadius: BorderRadius.circular(16),
                                  child: _buildItemCard(item, isDragging: true),
                                ),
                              ),
                              child: _buildItemCard(item),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                SizedBox(width: 20),

                // Drop Targets (Shadows)
                Expanded(
                  child: Column(
                    children:
                        reverseItem.map((item) {
                          return DragTarget<ItemModel>(
                            onAccept:
                                (receivedItem) =>
                                    _handleAccept(item, receivedItem),
                            onWillAccept: (receivedItem) {
                              setState(() {
                                item.accepting = true;
                              });
                              return true;
                            },
                            onLeave: (receivedItem) {
                              setState(() {
                                item.accepting = false;
                              });
                            },
                            builder: (context, acceptedItems, rejectedItems) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color:
                                        item.accepting
                                            ? item.color.withOpacity(0.2)
                                            : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color:
                                          item.accepting
                                              ? item.color
                                              : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  height: 90,
                                  alignment: Alignment.center,
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.7),
                                      BlendMode.srcATop,
                                    ),
                                    child: Image.asset(
                                      item.img,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 30),
        // Help Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Drag the colorful items to match with their shadows!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue.shade800,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(ItemModel item, {bool isDragging = false}) {
    return Material(
      elevation: isDragging ? 8 : 4,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: Container(
        width: 110,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, item.color.withOpacity(0.1)],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.img,
                    fit: BoxFit.contain,
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: item.color,
                    ),
                  ),
                ],
              ),
            ),
            if (isDragging)
              Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.touch_app, color: item.color, size: 16),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameOverScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Result Animation
            Container(
              width: 250,
              height: 150,
              child: rive.RiveAnimation.asset(
                score == 70
                    ? 'assets/rive/winner.riv'
                    : 'assets/rive/loser.riv',
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 20),
            // Game Over Text
            Text(
              'Game Over!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.white,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            // Result Message
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _getResultMessage(),
                style: TextStyle(fontSize: 22, color: Colors.blue.shade800),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 30),
            // Score Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade200, Colors.purple.shade200],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Your Score',
                    style: TextStyle(fontSize: 18, color: Colors.blue.shade900),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) {
                      return Icon(
                        index < (score ~/ 10) ? Icons.star : Icons.star_border,
                        color: Colors.yellow.shade700,
                        size: 24,
                      );
                    }),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButtons(
                  text: 'Play Again',
                  icon: Icons.replay,
                  onPressed: () {
                    setState(() {
                      initGame();
                      _titleAnimationController.reset();
                      _titleAnimationController.forward();
                    });
                  },
                  color: Colors.blue,
                ),
                SizedBox(width: 20),
                _buildActionButtons(
                  text: 'More Games',
                  icon: Icons.games,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return FittedBox(
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 20),
        label: Text(text, style: TextStyle(fontSize: 12)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  String _getResultMessage() {
    if (score == 70) {
      _playSound('success.wav');
      return 'Perfect! You matched all shadows correctly! 🎉';
    } else if (score >= 40) {
      _playSound('success.wav');
      return 'Great job! You\'re a shadow matching expert! 😊';
    } else {
      _playSound('tryAgain.wav');
      return 'Nice try! Practice makes perfect! 💪';
    }
  }
}

class _BubblePainter extends CustomPainter {
  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..style = PaintingStyle.fill;

    // Draw random bubbles
    for (int i = 0; i < 20; i++) {
      final radius = random.nextDouble() * 30 + 10;
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
