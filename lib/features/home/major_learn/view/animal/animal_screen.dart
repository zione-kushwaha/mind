import 'package:abc/features/home/major_learn/view/animal/animal_test.dart';
import 'package:abc/features/home/major_learn/view/color/color_screen.dart';
import 'package:abc/features/home/major_learn/view/school/school_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AnimalScreen extends StatefulWidget {
  static const String routeName = '/animals';
  @override
  State<AnimalScreen> createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _animalItems = [
    {
      'title': 'Cat',
      'image': 'assets/image/cat.png',
      'color': Color(0xFFF06292), // Pink
      'phrases': [
        {'text': 'I Like Cat', 'icon': Icons.favorite},
        {'text': 'I Saw a Cat', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Cat Make?', 'icon': Icons.volume_up},
        {'text': 'Can We get a Cat as Pet?', 'icon': Icons.pets},
      ],
    },
    {
      'title': 'Dog',
      'image': 'assets/image/dog.png',
      'color': Color(0xFF4FC3F7), // Blue
      'phrases': [
        {'text': 'I Like Dog', 'icon': Icons.favorite},
        {'text': 'I Saw a Dog', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Dog Make?', 'icon': Icons.volume_up},
        {'text': 'Can We get a Dog as Pet?', 'icon': Icons.pets},
      ],
    },
    {
      'title': 'Fish',
      'image': 'assets/image/fish.png',
      'color': Color(0xFF9575CD), // Purple
      'phrases': [
        {'text': 'I Like Fish', 'icon': Icons.favorite},
        {'text': 'I Saw a Fish', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Fish Make?', 'icon': Icons.volume_up},
        {'text': 'Can We get a Fish as Pet?', 'icon': Icons.pets},
      ],
    },
    {
      'title': 'Butterfly',
      'image': 'assets/image/butterfly.png',
      'color': Color(0xFF81C784), // Green
      'phrases': [
        {'text': 'I Like Butterflies', 'icon': Icons.favorite},
        {'text': 'I Saw a Butterfly', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Butterfly Make?', 'icon': Icons.volume_up},
        {'text': 'Can We get a Butterfly as Pet?', 'icon': Icons.pets},
      ],
    },
    {
      'title': 'Rabbit',
      'image': 'assets/image/rabbit.png',
      'color': Color(0xFFFFB74D), // Orange
      'phrases': [
        {'text': 'I Like Rabbit', 'icon': Icons.favorite},
        {'text': 'I Saw a Rabbit', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Rabbit Make?', 'icon': Icons.volume_up},
        {'text': 'Can We get a Rabbit as Pet?', 'icon': Icons.pets},
      ],
    },
    {
      'title': 'Kangaroo',
      'image': 'assets/image/kangaroo.png',
      'color': Color(0xFFE57373), // Red
      'phrases': [
        {'text': 'I Like Kangaroo', 'icon': Icons.favorite},
        {'text': 'I Saw a Kangaroo', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Kangaroo Make?', 'icon': Icons.volume_up},
        {'text': 'Can I See The Kangaroo?', 'icon': Icons.visibility},
      ],
    },
    {
      'title': 'Frog',
      'image': 'assets/image/frog.png',
      'color': Color(0xFF7986CB), // Indigo
      'phrases': [
        {'text': 'I Like Frog', 'icon': Icons.favorite},
        {'text': 'I Saw a Frog', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Frog Make?', 'icon': Icons.volume_up},
        {'text': 'Can We get a Frog as Pet?', 'icon': Icons.pets},
      ],
    },
    {
      'title': 'Giraffe',
      'image': 'assets/image/giraffe.png',
      'color': Color(0xFF4DB6AC), // Teal
      'phrases': [
        {'text': 'I Like Giraffe', 'icon': Icons.favorite},
        {'text': 'I Saw a Giraffe', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Giraffe Make?', 'icon': Icons.volume_up},
        {'text': 'Can I See The Giraffe?', 'icon': Icons.visibility},
      ],
    },
    {
      'title': 'Turtle',
      'image': 'assets/image/turtle.png',
      'color': Color(0xFFBA68C8), // Deep Purple
      'phrases': [
        {'text': 'I Like Turtle', 'icon': Icons.favorite},
        {'text': 'I Saw a Turtle', 'icon': Icons.remove_red_eye},
        {'text': 'What Noise Does a Turtle Make?', 'icon': Icons.volume_up},
        {'text': 'Can We get a Turtle as Pet?', 'icon': Icons.pets},
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

  void _showAnimalDetails(int index) {
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
                      _animalItems[index]['color'].withOpacity(0.5),
                      _animalItems[index]['color'].withOpacity(0.3),
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
                          tag: 'animal-${_animalItems[index]['title']}',
                          child: Image.asset(
                            _animalItems[index]['image'],
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
                          color: _animalItems[index]['color'],
                        ),
                        onPressed: () => _speak(_animalItems[index]['title']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Animal title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _animalItems[index]['title'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _animalItems[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _animalItems[index]['phrases'].length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (ctx, i) => SizedBox(height: 12),
                  itemBuilder: (ctx, phraseIndex) {
                    final phrase = _animalItems[index]['phrases'][phraseIndex];
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
                                    color: _animalItems[index]['color']
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    phrase['icon'],
                                    color: _animalItems[index]['color'],
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
                                    color: _animalItems[index]['color'],
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
                    backgroundColor: _animalItems[index]['color'],
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
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text('Animals'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
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
                          'Animals',
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
                            Navigator.pushNamed(context, AnimalTest.routeName);
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
                        itemCount: _animalItems.length,
                        itemBuilder: (ctx, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: InkWell(
                              onTap: () {
                                _speak(_animalItems[index]['title']);
                                _showAnimalDetails(index);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _animalItems[index]['color'],
                                      _animalItems[index]['color'].withOpacity(
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
                                          'animal-${_animalItems[index]['title']}',
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
                                            _animalItems[index]['image'],
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      _animalItems[index]['title'],
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
                  'School',
                  'assets/image/school.png',
                  Colors.redAccent,
                  () {
                    Navigator.pushNamed(context, SchoolScreen.routeName);
                  },
                ),
                _buildNavButton(
                  context,
                  'Colors',
                  'assets/image/colors.png',
                  const Color.fromARGB(255, 18, 201, 58),
                  () {
                    Navigator.pushNamed(context, ColorScreen.routeName);
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
