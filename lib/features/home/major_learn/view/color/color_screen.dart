import 'package:abc/features/home/major_learn/view/animal/animal_screen.dart';
import 'package:abc/features/home/major_learn/view/color/color_test.dart';
import 'package:abc/features/home/major_learn/view/food/food_screen.dart';
import 'package:abc/features/home/major_learn/view/school/school_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ColorScreen extends StatefulWidget {
  static const String routeName = '/colors';
  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _colorsList = [
    {
      'title': 'Crayons',
      'image': 'assets/image/caryons.png',
      'color': Color(0xFFFFA000), // Amber
      'phrases': [
        {'text': 'I Like Crayons', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Crayons?', 'icon': Icons.help},
        {'text': 'I Want to Draw Using My Crayons', 'icon': Icons.brush},
      ],
    },
    {
      'title': 'Red',
      'image': 'assets/image/red.png',
      'color': Color(0xFFF44336), // Red
      'phrases': [
        {'text': 'It Is Red', 'icon': Icons.color_lens},
        {'text': 'My Favorite Color Is Red', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Red Paint?', 'icon': Icons.help},
      ],
    },
    {
      'title': 'Blue',
      'image': 'assets/image/blue.png',
      'color': Color(0xFF2196F3), // Blue
      'phrases': [
        {'text': 'It Is Blue', 'icon': Icons.color_lens},
        {'text': 'My Favorite Color Is Blue', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Blue Paint?', 'icon': Icons.help},
      ],
    },
    {
      'title': 'Orange',
      'image': 'assets/image/orange.png',
      'color': Color(0xFFFF9800), // Orange
      'phrases': [
        {'text': 'It Is Orange', 'icon': Icons.color_lens},
        {'text': 'My Favorite Color Is Orange', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Orange Paint?', 'icon': Icons.help},
      ],
    },
    {
      'title': 'Green',
      'image': 'assets/image/green.png',
      'color': Color(0xFF4CAF50), // Green
      'phrases': [
        {'text': 'It Is Green', 'icon': Icons.color_lens},
        {'text': 'My Favorite Color Is Green', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Green Paint?', 'icon': Icons.help},
      ],
    },
    {
      'title': 'Yellow',
      'image': 'assets/image/yellow.png',
      'color': Color(0xFFFFEB3B), // Yellow
      'phrases': [
        {'text': 'It Is Yellow', 'icon': Icons.color_lens},
        {'text': 'My Favorite Color Is Yellow', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Yellow Paint?', 'icon': Icons.help},
      ],
    },
    {
      'title': 'Purple',
      'image': 'assets/image/purple.png',
      'color': Color(0xFF9C27B0), // Purple
      'phrases': [
        {'text': 'It Is Purple', 'icon': Icons.color_lens},
        {'text': 'My Favorite Color Is Purple', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Purple Paint?', 'icon': Icons.help},
      ],
    },
    {
      'title': 'Pink',
      'image': 'assets/image/pink.png',
      'color': Color(0xFFE91E63), // Pink
      'phrases': [
        {'text': 'It Is Pink', 'icon': Icons.color_lens},
        {'text': 'My Favorite Color Is Pink', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Pink Paint?', 'icon': Icons.help},
      ],
    },
    {
      'title': 'Brown',
      'image': 'assets/image/brown.png',
      'color': Color(0xFF795548), // Brown
      'phrases': [
        {'text': 'It Is Brown', 'icon': Icons.color_lens},
        {'text': 'My Favorite Color Is Brown', 'icon': Icons.favorite},
        {'text': 'Can You Give Me Brown Paint?', 'icon': Icons.help},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.5);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  Future _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    _animationController.dispose();
    super.dispose();
  }

  void _showColorDetails(int index) {
    _animationController.forward();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 15, spreadRadius: 2),
            ],
          ),
          child: Column(
            children: [
              // Header with image
              Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _colorsList[index]['color'].withOpacity(0.5),
                      _colorsList[index]['color'].withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Hero(
                          tag: 'color-${_colorsList[index]['title']}',
                          child: Image.asset(
                            _colorsList[index]['image'],
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 25,
                      top: 25,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.volume_up,
                          color: _colorsList[index]['color'],
                        ),
                        onPressed: () => _speak(_colorsList[index]['title']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Color title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _colorsList[index]['title'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _colorsList[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _colorsList[index]['phrases'].length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (ctx, i) => SizedBox(height: 12),
                  itemBuilder: (ctx, phraseIndex) {
                    final phrase = _colorsList[index]['phrases'][phraseIndex];
                    return ScaleTransition(
                      scale: _animation,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () => _speak(phrase['text']),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _colorsList[index]['color']
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    phrase['icon'],
                                    color: _colorsList[index]['color'],
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    phrase['text'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.volume_up,
                                    color: _colorsList[index]['color'],
                                  ),
                                  onPressed: () => _speak(phrase['text']),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Close button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _colorsList[index]['color'],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    _animationController.reset();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _animationController.reset());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Color',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Colors',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.quiz, size: 18, color: Colors.white),
                          label: Text(
                            'Take a Test',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, ColorTest.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: _colorsList.length,
                        itemBuilder: (ctx, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: InkWell(
                              onTap: () {
                                _speak(_colorsList[index]['title']);
                                _showColorDetails(index);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _colorsList[index]['color'],
                                      _colorsList[index]['color'].withOpacity(
                                        0.8,
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Hero(
                                      tag:
                                          'color-${_colorsList[index]['title']}',
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 6,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            _colorsList[index]['image'],
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      _colorsList[index]['title'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Navigation buttons
          Container(
            height: 80,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavButton(
                  context,
                  'Animals',
                  'assets/image/animals.png',
                  Colors.orangeAccent,
                  () {
                    Navigator.pushNamed(context, AnimalScreen.routeName);
                  },
                ),
                _buildNavButton(
                  context,
                  'Food',
                  'assets/image/food.png',
                  Colors.greenAccent,
                  () {
                    Navigator.pushNamed(context, FoodScreen.routeName);
                  },
                  reverse: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String text,
    String image,
    Color color,
    VoidCallback onPressed, {
    bool reverse = false,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment:
                reverse
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
            children:
                reverse
                    ? [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(image, width: 30, height: 30),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white,
                      ),
                    ]
                    : [
                      Icon(Icons.arrow_back_ios, size: 16, color: Colors.white),
                      Image.asset(image, width: 30, height: 30),
                      SizedBox(width: 8),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
          ),
        ),
      ),
    );
  }
}
