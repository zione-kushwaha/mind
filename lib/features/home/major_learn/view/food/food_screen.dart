import 'package:abc/features/home/major_learn/view/color/color_screen.dart';
import 'package:abc/features/home/major_learn/view/feeling/feeling_test.dart';
import 'package:abc/features/home/major_learn/view/feeling/felling_screen.dart';
import 'package:abc/features/home/major_learn/view/food/food_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FoodScreen extends StatefulWidget {
  static const String routeName = '/food';
  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _foodList = [
    {
      'title': 'Hungry',
      'image': 'assets/image/hungry.png',
      'color': Color(0xFFFFA000), // Amber
      'phrases': [
        {'text': 'I\'m Hungry', 'icon': Icons.fastfood},
        {'text': 'Are You Hungry?', 'icon': Icons.question_answer},
        {'text': 'Can You Make Me Food?', 'icon': Icons.help},
        {'text': 'What is For Dinner?', 'icon': Icons.dinner_dining},
      ],
    },
    {
      'title': 'Thirsty',
      'image': 'assets/image/thirsty.png',
      'color': Color(0xFF4FC3F7), // Blue
      'phrases': [
        {'text': 'I\'m Thirsty', 'icon': Icons.local_drink},
        {'text': 'Can I Have Some Water?', 'icon': Icons.water_drop},
        {'text': 'Can I Have a glass Of Water?', 'icon': Icons.local_drink},
        {'text': 'I Want Something to Drink', 'icon': Icons.local_cafe},
      ],
    },
    {
      'title': 'Cutlery',
      'image': 'assets/image/cutlery.png',
      'color': Color(0xFF9575CD), // Purple
      'phrases': [
        {'text': 'I Need Cutlery', 'icon': Icons.restaurant},
        {'text': 'Help Me Use Cutlery', 'icon': Icons.help},
        {'text': 'I Need a Knife', 'icon': Icons.restaurant},
        {'text': 'I Need a Spoon', 'icon': Icons.restaurant},
      ],
    },
    {
      'title': 'Apple',
      'image': 'assets/image/apple.png',
      'color': Color(0xFFE57373), // Red
      'phrases': [
        {'text': 'I Like Apple', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Apple', 'icon': Icons.favorite_border},
        {'text': 'I Want to Eat an Apple', 'icon': Icons.shopping_basket},
        {'text': 'Can You give Me an Apple?', 'icon': Icons.question_answer},
      ],
    },
    {
      'title': 'Carrot',
      'image': 'assets/image/carrot.png',
      'color': Color(0xFFFFB74D), // Orange
      'phrases': [
        {'text': 'I Like Carrot', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Carrot', 'icon': Icons.favorite_border},
        {'text': 'I Want to Eat a Carrot', 'icon': Icons.shopping_basket},
        {'text': 'Can You give Me a Carrot?', 'icon': Icons.question_answer},
      ],
    },
    {
      'title': 'Beans',
      'image': 'assets/image/beans.png',
      'color': Color(0xFF81C784), // Green
      'phrases': [
        {'text': 'I Like Beans', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Beans', 'icon': Icons.favorite_border},
        {'text': 'I Want to Eat Beans', 'icon': Icons.shopping_basket},
        {'text': 'Can You give Me Beans?', 'icon': Icons.question_answer},
      ],
    },
    {
      'title': 'Chicken',
      'image': 'assets/image/chicken.png',
      'color': Color(0xFFF06292), // Pink
      'phrases': [
        {'text': 'I Like Chicken', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Chicken', 'icon': Icons.favorite_border},
        {'text': 'I Want to Eat Chicken', 'icon': Icons.shopping_basket},
        {'text': 'I Want Fried Chicken', 'icon': Icons.fastfood},
      ],
    },
    {
      'title': 'Chocolate',
      'image': 'assets/image/chocolate.png',
      'color': Color(0xFF795548), // Brown
      'phrases': [
        {'text': 'I Like Chocolate', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Chocolate', 'icon': Icons.favorite_border},
        {'text': 'I Want to Eat Chocolate', 'icon': Icons.shopping_basket},
        {'text': 'I Want Dark Chocolate', 'icon': Icons.cake},
      ],
    },
    {
      'title': 'Milk',
      'image': 'assets/image/milk.png',
      'color': Color(0xFF90CAF9), // Light Blue
      'phrases': [
        {'text': 'I Like Milk', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Milk', 'icon': Icons.favorite_border},
        {'text': 'I Want to Drink Milk', 'icon': Icons.local_cafe},
        {'text': 'Can I Have a glass Of Milk?', 'icon': Icons.question_answer},
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

  void _showFoodDetails(int index) {
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
                      _foodList[index]['color'].withOpacity(0.5),
                      _foodList[index]['color'].withOpacity(0.3),
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
                          tag: 'food-${_foodList[index]['title']}',
                          child: Image.asset(
                            _foodList[index]['image'],
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
                          color: _foodList[index]['color'],
                        ),
                        onPressed: () => _speak(_foodList[index]['title']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Food title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _foodList[index]['title'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _foodList[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _foodList[index]['phrases'].length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (ctx, i) => SizedBox(height: 12),
                  itemBuilder: (ctx, phraseIndex) {
                    final phrase = _foodList[index]['phrases'][phraseIndex];
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
                                    color: _foodList[index]['color']
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    phrase['icon'],
                                    color: _foodList[index]['color'],
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
                                    color: _foodList[index]['color'],
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
                    backgroundColor: _foodList[index]['color'],
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
          'Food',
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
                          'Food',
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
                            Navigator.pushNamed(context, FoodTest.routeName);
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
                        itemCount: _foodList.length,
                        itemBuilder: (ctx, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: InkWell(
                              onTap: () {
                                _speak(_foodList[index]['title']);
                                _showFoodDetails(index);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _foodList[index]['color'],
                                      _foodList[index]['color'].withOpacity(
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
                                      tag: 'food-${_foodList[index]['title']}',
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
                                            _foodList[index]['image'],
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      _foodList[index]['title'],
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
                  'Colors',
                  'assets/image/colors.png',
                  const Color.fromARGB(255, 18, 215, 230),
                  () {
                    Navigator.pushNamed(context, ColorScreen.routeName);
                  },
                ),
                _buildNavButton(
                  context,
                  'Feelings',
                  'assets/image/feeling.png',
                  const Color.fromARGB(255, 24, 78, 255),
                  () {
                    Navigator.pushNamed(context, FeelingScreen.routeName);
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
