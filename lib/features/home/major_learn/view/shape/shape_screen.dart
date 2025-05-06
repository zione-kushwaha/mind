import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ShapeScreen extends StatefulWidget {
  static const String routeName = '/shapes';
  @override
  State<ShapeScreen> createState() => _ShapeScreenState();
}

class _ShapeScreenState extends State<ShapeScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _shapeItems = [
    {
      'title': 'Circle',
      'image': 'assets/image/circle.png',
      'color': Color(0xFFF06292), // Pink
      'phrases': [
        {'text': 'This Is Circle Shaped', 'icon': Icons.circle},
        {'text': 'Can You Teach Me How to Draw a Circle?', 'icon': Icons.edit},
        {'text': 'I See Circles Everywhere', 'icon': Icons.remove_red_eye},
        {'text': 'The Moon Is a Circle', 'icon': Icons.nightlight_round},
      ],
    },
    {
      'title': 'Triangle',
      'image': 'assets/image/triangle.png',
      'color': Color(0xFF4FC3F7), // Blue
      'phrases': [
        {'text': 'This Is Triangle Shaped', 'icon': Icons.change_history},
        {
          'text': 'Can You Teach Me How to Draw a Triangle?',
          'icon': Icons.edit,
        },
        {'text': 'A Pyramid Is a Triangle', 'icon': Icons.landscape},
        {'text': 'I Like Triangle Shapes', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Square',
      'image': 'assets/image/square.png',
      'color': Color(0xFF9575CD), // Purple
      'phrases': [
        {'text': 'This Is Square Shaped', 'icon': Icons.crop_square},
        {'text': 'Can You Teach Me How to Draw a Square?', 'icon': Icons.edit},
        {'text': 'My Window Is Square', 'icon': Icons.window},
        {'text': 'Squares Have Four Equal Sides', 'icon': Icons.square_foot},
      ],
    },
    {
      'title': 'Rectangle',
      'image': 'assets/image/tectangle.png',
      'color': Color(0xFF81C784), // Green
      'phrases': [
        {'text': 'This Is Rectangle Shaped', 'icon': Icons.rectangle},
        {
          'text': 'Can You Teach Me How to Draw a Rectangle?',
          'icon': Icons.edit,
        },
        {'text': 'My Book Is Rectangle', 'icon': Icons.book},
        {'text': 'Doors Are Rectangles', 'icon': Icons.door_back_door},
      ],
    },
    {
      'title': 'Star',
      'image': 'assets/image/star.png',
      'color': Color(0xFFFFB74D), // Orange
      'phrases': [
        {'text': 'This Is Star Shaped', 'icon': Icons.star},
        {'text': 'Can You Teach Me How to Draw a Star?', 'icon': Icons.edit},
        {'text': 'Stars Twinkle at Night', 'icon': Icons.nightlight_round},
        {'text': 'I Like Star Shapes', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Pentagon',
      'image': 'assets/image/pentagon.png',
      'color': Color(0xFFE57373), // Red
      'phrases': [
        {'text': 'This Is Pentagon Shaped', 'icon': Icons.pentagon},
        {
          'text': 'Can You Teach Me How to Draw a Pentagon?',
          'icon': Icons.edit,
        },
        {'text': 'A Pentagon Has Five Sides', 'icon': Icons.looks_5},
        {'text': 'Some Signs Are Pentagons', 'icon': Icons.traffic},
      ],
    },
    {
      'title': 'Hexagon',
      'image': 'assets/image/hexagon.png',
      'color': Color(0xFF7986CB), // Indigo
      'phrases': [
        {'text': 'This Is Hexagon Shaped', 'icon': Icons.hexagon},
        {'text': 'Can You Teach Me How to Draw a Hexagon?', 'icon': Icons.edit},
        {'text': 'A Hexagon Has Six Sides', 'icon': Icons.looks_6},
        {'text': 'Honeycombs Are Hexagons', 'icon': Icons.hive},
      ],
    },
    {
      'title': 'Cross',
      'image': 'assets/image/cross.png',
      'color': Color(0xFF4DB6AC), // Teal
      'phrases': [
        {'text': 'This Is Cross Shaped', 'icon': Icons.add},
        {'text': 'Can You Teach Me How to Draw a Cross?', 'icon': Icons.edit},
        {'text': 'Some Roads Make a Cross', 'icon': Icons.alt_route},
        {'text': 'The Hospital Sign Has a Cross', 'icon': Icons.local_hospital},
      ],
    },
    {
      'title': 'Ellipse',
      'image': 'assets/image/ellipse.png',
      'color': Color(0xFFBA68C8), // Deep Purple
      'phrases': [
        {'text': 'This Is Ellipse Shaped', 'icon': Icons.egg},
        {
          'text': 'Can You Teach Me How to Draw an Ellipse?',
          'icon': Icons.edit,
        },
        {'text': 'An Egg Is Ellipse Shaped', 'icon': Icons.breakfast_dining},
        {'text': 'Some Planets Are Ellipses', 'icon': Icons.place},
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

  void _showShapeDetails(int index) {
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
                      _shapeItems[index]['color'].withOpacity(0.5),
                      _shapeItems[index]['color'].withOpacity(0.3),
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
                          tag: 'shape-${_shapeItems[index]['title']}',
                          child: Image.asset(
                            _shapeItems[index]['image'],
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
                          color: _shapeItems[index]['color'],
                        ),
                        onPressed: () => _speak(_shapeItems[index]['title']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Shape title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _shapeItems[index]['title'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _shapeItems[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _shapeItems[index]['phrases'].length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (ctx, i) => SizedBox(height: 12),
                  itemBuilder: (ctx, phraseIndex) {
                    final phrase = _shapeItems[index]['phrases'][phraseIndex];
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
                                    color: _shapeItems[index]['color']
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    phrase['icon'],
                                    color: _shapeItems[index]['color'],
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
                                    color: _shapeItems[index]['color'],
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
                    backgroundColor: _shapeItems[index]['color'],
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
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(
          'Shapes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
                          'Shapes',
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => ShapeTest()),
                            // );
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
                        itemCount: _shapeItems.length,
                        itemBuilder: (ctx, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: InkWell(
                              onTap: () {
                                _speak(_shapeItems[index]['title']);
                                _showShapeDetails(index);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _shapeItems[index]['color'],
                                      _shapeItems[index]['color'].withOpacity(
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
                                          'shape-${_shapeItems[index]['title']}',
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
                                            _shapeItems[index]['image'],
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      _shapeItems[index]['title'],
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
                  'Numbers',
                  'assets/image/numbers2.png',
                  Colors.pinkAccent,
                  () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (ctx) => NumberScreen()),
                    // );
                  },
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
                      Icon(Icons.arrow_back_ios, size: 13, color: Colors.white),
                      Image.asset(image, width: 25, height: 30),
                      SizedBox(width: 8),
                      FittedBox(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
          ),
        ),
      ),
    );
  }
}
