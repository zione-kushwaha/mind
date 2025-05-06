import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumberScreen extends StatefulWidget {
  static const String routeName = '/numbers';
  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _numbersList = [
    {
      'title': 'One',
      'image': 'assets/image/one.png',
      'color': Color(0xFFF06292), // Pink
      'phrases': [
        {'text': 'One Comes Before Two', 'icon': Icons.arrow_upward},
        {'text': 'One Comes After Zero', 'icon': Icons.arrow_downward},
        {'text': 'I Want One', 'icon': Icons.shopping_cart},
      ],
    },
    {
      'title': 'Two',
      'image': 'assets/image/two.png',
      'color': Color(0xFF4FC3F7), // Blue
      'phrases': [
        {'text': 'Two Comes Before Three', 'icon': Icons.arrow_upward},
        {'text': 'Two Comes After One', 'icon': Icons.arrow_downward},
        {'text': 'I Want Two', 'icon': Icons.shopping_cart},
      ],
    },
    {
      'title': 'Three',
      'image': 'assets/image/three.png',
      'color': Color(0xFF9575CD), // Purple
      'phrases': [
        {'text': 'Three Comes Before Four', 'icon': Icons.arrow_upward},
        {'text': 'Three Comes After Two', 'icon': Icons.arrow_downward},
        {'text': 'I Want Three', 'icon': Icons.shopping_cart},
      ],
    },
    {
      'title': 'Four',
      'image': 'assets/image/four.png',
      'color': Color(0xFF81C784), // Green
      'phrases': [
        {'text': 'Four Comes Before Five', 'icon': Icons.arrow_upward},
        {'text': 'Four Comes After Three', 'icon': Icons.arrow_downward},
        {'text': 'I Want Four', 'icon': Icons.shopping_cart},
      ],
    },
    {
      'title': 'Five',
      'image': 'assets/image/five.png',
      'color': Color(0xFFFFB74D), // Orange
      'phrases': [
        {'text': 'Five Comes Before Six', 'icon': Icons.arrow_upward},
        {'text': 'Five Comes After Four', 'icon': Icons.arrow_downward},
        {'text': 'I Want Five', 'icon': Icons.shopping_cart},
      ],
    },
    {
      'title': 'Six',
      'image': 'assets/image/six.png',
      'color': Color(0xFFE57373), // Red
      'phrases': [
        {'text': 'Six Comes Before Seven', 'icon': Icons.arrow_upward},
        {'text': 'Six Comes After Five', 'icon': Icons.arrow_downward},
        {'text': 'I Want Six', 'icon': Icons.shopping_cart},
      ],
    },
    {
      'title': 'Seven',
      'image': 'assets/image/sevn.png',
      'color': Color(0xFF7986CB), // Indigo
      'phrases': [
        {'text': 'Seven Comes Before Eight', 'icon': Icons.arrow_upward},
        {'text': 'Seven Comes After Six', 'icon': Icons.arrow_downward},
        {'text': 'I Want Seven', 'icon': Icons.shopping_cart},
      ],
    },
    {
      'title': 'Eight',
      'image': 'assets/image/eight.png',
      'color': Color(0xFF4DB6AC), // Teal
      'phrases': [
        {'text': 'Eight Comes Before Nine', 'icon': Icons.arrow_upward},
        {'text': 'Eight Comes After Seven', 'icon': Icons.arrow_downward},
        {'text': 'I Want Eight', 'icon': Icons.shopping_cart},
      ],
    },
    {
      'title': 'Nine',
      'image': 'assets/image/nine.png',
      'color': Color(0xFFBA68C8), // Deep Purple
      'phrases': [
        {'text': 'Nine Comes Before Ten', 'icon': Icons.arrow_upward},
        {'text': 'Nine Comes After Eight', 'icon': Icons.arrow_downward},
        {'text': 'I Want Nine', 'icon': Icons.shopping_cart},
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

  void _showNumberDetails(int index) {
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
                      _numbersList[index]['color'].withOpacity(0.5),
                      _numbersList[index]['color'].withOpacity(0.3),
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
                          tag: 'number-${_numbersList[index]['title']}',
                          child: Image.asset(
                            _numbersList[index]['image'],
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
                          color: _numbersList[index]['color'],
                        ),
                        onPressed: () => _speak(_numbersList[index]['title']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Number title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _numbersList[index]['title'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _numbersList[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _numbersList[index]['phrases'].length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (ctx, i) => SizedBox(height: 12),
                  itemBuilder: (ctx, phraseIndex) {
                    final phrase = _numbersList[index]['phrases'][phraseIndex];
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
                                    color: _numbersList[index]['color']
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    phrase['icon'],
                                    color: _numbersList[index]['color'],
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
                                    color: _numbersList[index]['color'],
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
                    backgroundColor: _numbersList[index]['color'],
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
        title: const Text(
          'Numbers',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
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
                          'Numbers',
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
                            //   MaterialPageRoute(builder: (context) => NumberTest()),
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
                        itemCount: _numbersList.length,
                        itemBuilder: (ctx, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: InkWell(
                              onTap: () {
                                _speak(_numbersList[index]['title']);
                                _showNumberDetails(index);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _numbersList[index]['color'],
                                      _numbersList[index]['color'].withOpacity(
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
                                          'number-${_numbersList[index]['title']}',
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
                                            _numbersList[index]['image'],
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      _numbersList[index]['title'],
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
                  'Activities',
                  'assets/image/activites.png',
                  Colors.lightGreen.shade400,
                  () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (ctx) => ActivityScreen()),
                    // );
                  },
                ),
                _buildNavButton(
                  context,
                  'Shapes',
                  'assets/image/shapes.png',
                  Colors.amber.shade300,
                  () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (ctx) => ShapeScreen()),
                    // );
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
                      FittedBox(
                        child: Text(
                          text,
                          style: TextStyle(
                            // fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                      Image.asset(image, width: 25, height: 30),
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
