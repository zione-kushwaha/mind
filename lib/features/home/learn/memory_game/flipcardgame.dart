import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:confetti/confetti.dart';
import '../../../../core/local/component.dart';
import 'data.dart';
import 'dart:async';

class FlipCardGane extends StatefulWidget {
  final Level _level;
  FlipCardGane(this._level);
  @override
  _FlipCardGaneState createState() => _FlipCardGaneState(_level);
}

class _FlipCardGaneState extends State<FlipCardGane> {
  _FlipCardGaneState(this._level);

  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  Level _level;
  late Timer _timer = Timer(
    const Duration(seconds: 0),
    () {},
  ); // Initialize _timer
  int _time = 5;
  late int _left;
  late bool _isFinished;
  late List<String> _data;
  int tries = 0;
  int score = 0;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;
  late ConfettiController _confettiController;
  final List<Color> _cardColors = [
    Color(0xFFF06292),
    Color(0xFFBA68C8),
    Color(0xFF4FC3F7),
    Color(0xFF4DB6AC),
    Color(0xFFAED581),
    Color(0xFFFFD54F),
    Color(0xFFFF8A65),
    Color(0xFFA1887F),
    Color(0xFF90A4AE),
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );
    restart();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _confettiController.dispose();
    super.dispose();
  }

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(2, 3),
          ),
        ],
      ),
      margin: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(_data[index], fit: BoxFit.cover),
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = _time - 1;
      });
    });
  }

  void restart() {
    if (_timer.isActive) _timer.cancel();

    startTimer();
    _data = getSourceArray(_level).cast<String>();
    _cardFlips = getInitialItemState(_level);
    _cardStateKeys = getCardStateKeys(_level);
    _time = 5;
    _left = (_data.length ~/ 2);
    _isFinished = false;
    tries = 0;
    score = 0;

    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  Widget _buildFrontCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(2, 3),
          ),
        ],
      ),
      margin: EdgeInsets.all(8.0),
      child: Center(
        child: Icon(
          Icons.help_outline,
          color: Colors.white.withOpacity(0.8),
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isFinished
        ? Stack(
          children: [
            Scaffold(
              backgroundColor: Color(0xFF1A237E),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustombackAppBar(context, () {
                      Navigator.pop(context);
                    }),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 200,
                      child: rive.RiveAnimation.asset(
                        'assets/rive/winner.riv',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "CONGRATULATIONS!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "You've mastered this level!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 300,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _buildScoreRow(Icons.star, "Score", "$score"),
                          SizedBox(height: 15),
                          _buildScoreRow(Icons.repeat, "Tries", "$tries"),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        restart();
                        setState(() {
                          _isFinished = false;
                        });
                      },
                      child: Text(
                        "Play Again",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ConfettiWidget(
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
            ),
          ],
        )
        : Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                CustombackAppBar(context, () {
                  Navigator.pop(context);
                }),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child:
                      _time > 0
                          ? Text(
                            'Game starts in: $_time',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A237E),
                            ),
                          )
                          : Text(
                            'Pairs left: $_left',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A237E),
                            ),
                          ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoCard("Tries", "$tries", Icons.repeat),
                    _buildInfoCard("Score", "$score", Icons.star),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder:
                          (context, index) =>
                              _start
                                  ? _buildPlayableCard(index)
                                  : _buildPreviewCard(index),
                      itemCount: _data.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  Widget _buildPlayableCard(int index) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: FlipCard(
        key: _cardStateKeys[index],
        onFlip: () => _handleCardFlip(index),
        flipOnTouch: _wait ? false : _cardFlips[index],
        direction: FlipDirection.HORIZONTAL,
        front: _buildFrontCard(),
        back: getItem(index),
      ),
    );
  }

  Widget _buildPreviewCard(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _cardColors[index % _cardColors.length],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(2, 3),
          ),
        ],
      ),
      margin: EdgeInsets.all(8.0),
      child: getItem(index),
    );
  }

  void _handleCardFlip(int index) {
    if (!_flip) {
      _flip = true;
      _previousIndex = index;
    } else {
      _flip = false;
      if (_previousIndex != index) {
        if (_data[_previousIndex] != _data[index]) {
          _wait = true;
          setState(() {
            tries++;
          });

          Future.delayed(const Duration(milliseconds: 1500), () {
            _cardStateKeys[_previousIndex].currentState?.toggleCard();
            _cardStateKeys[index].currentState?.toggleCard();
            _wait = false;
          });
        } else {
          _cardFlips[_previousIndex] = false;
          _cardFlips[index] = false;
          setState(() {
            _left -= 1;
            score += 100;
            tries++;
          });

          if (_cardFlips.every((t) => t == false)) {
            _confettiController.play();
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _isFinished = true;
                _start = false;
              });
            });
          }
        }
      }
    }
  }

  Widget _buildScoreRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.amber),
            SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A237E), Color(0xFF283593)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.amber),
              SizedBox(width: 8),
              Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
