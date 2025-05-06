import 'package:abc/features/home/major_learn/view/animal/animal_screen.dart';
import 'package:abc/features/home/major_learn/view/school/school_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../conversation/conversation.dart';

class SchoolScreen extends StatefulWidget {
  static const String routeName = '/school';
  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _schoolItems = [
    {
      'title': 'Book',
      'image': 'assets/image/book.png',
      'color': Color(0xFFF06292), // Pink
      'phrases': [
        {'text': 'TextBook', 'icon': Icons.book},
        {'text': 'WorkBook', 'icon': Icons.work},
        {'text': 'Reading a Book', 'icon': Icons.menu_book},
        {'text': 'Can I Borrow Your Book?', 'icon': Icons.handshake},
      ],
    },
    {
      'title': 'Chair',
      'image': 'assets/image/chair.png',
      'color': Color(0xFF4FC3F7), // Blue
      'phrases': [
        {'text': 'Can I Sit With You?', 'icon': Icons.chair},
        {'text': 'Which Chair Is Mine?', 'icon': Icons.help},
        {'text': 'I Spilled On My Chair', 'icon': Icons.water_damage},
        {'text': 'Is This Chair Taken?', 'icon': Icons.question_answer},
      ],
    },
    {
      'title': 'Desk',
      'image': 'assets/image/desk.png',
      'color': Color(0xFF9575CD), // Purple
      'phrases': [
        {'text': 'Can I Use This Desk?', 'icon': Icons.desk},
        {'text': 'Which Desk Is Mine?', 'icon': Icons.help},
        {'text': 'I Spilled On My Desk', 'icon': Icons.water_damage},
        {'text': 'Don\'t Scratch Your Desk', 'icon': Icons.warning},
      ],
    },
    {
      'title': 'Blackboard',
      'image': 'assets/image/blackboard.png',
      'color': Color(0xFF81C784), // Green
      'phrases': [
        {'text': 'Look at The Blackboard', 'icon': Icons.remove_red_eye},
        {'text': 'Cleaning The Blackboard', 'icon': Icons.cleaning_services},
        {'text': 'Give Me a Chalk', 'icon': Icons.edit},
        {'text': 'Taking Note On The Blackboard', 'icon': Icons.notes},
      ],
    },
    {
      'title': 'Backpack',
      'image': 'assets/image/backpack.png',
      'color': Color(0xFFFFB74D), // Orange
      'phrases': [
        {'text': 'Carrying My Backpack', 'icon': Icons.backpack},
        {'text': 'I Lost My Backpack', 'icon': Icons.luggage},
        {'text': 'I Need a New Backpack', 'icon': Icons.shopping_bag},
        {'text': 'Thank You For Carrying My Backpack', 'icon': Icons.handshake},
      ],
    },
    {
      'title': 'Notebook',
      'image': 'assets/image/notebook.png',
      'color': Color(0xFFE57373), // Red
      'phrases': [
        {'text': 'Taking Notes', 'icon': Icons.notes},
        {'text': 'I\'m Taking Notes', 'icon': Icons.edit_note},
        {'text': 'I Lost My Notebook', 'icon': CupertinoIcons.book},
        {'text': 'Can I Borrow Your Notebook?', 'icon': Icons.handshake},
      ],
    },
    {
      'title': 'Pencil',
      'image': 'assets/image/pencil.png',
      'color': Color(0xFF7986CB), // Indigo
      'phrases': [
        {'text': 'I\'m Writing', 'icon': Icons.edit},
        {'text': 'I\'m Learning to Write', 'icon': Icons.school},
        {'text': 'Can I Borrow Your Pencil?', 'icon': Icons.handshake},
        {'text': 'I Lost My Pencil', 'icon': Icons.search},
      ],
    },
    {
      'title': 'School bus',
      'image': 'assets/image/school bus.png',
      'color': Color(0xFF4DB6AC), // Teal
      'phrases': [
        {'text': 'School Bus Is Coming', 'icon': Icons.directions_bus},
        {'text': 'Can I Sit Next to You?', 'icon': Icons.chair},
        {'text': 'Thank You bus Driver!', 'icon': Icons.handshake},
        {'text': 'School bus Was Late', 'icon': Icons.timer_off},
      ],
    },
    {
      'title': 'Teacher',
      'image': 'assets/image/teacher.png',
      'color': Color(0xFFBA68C8), // Deep Purple
      'phrases': [
        {'text': 'I Don\'t Understand This Part', 'icon': Icons.help},
        {'text': 'Can I Go to The Restroom?', 'icon': Icons.wc},
        {'text': 'Thank You Teacher!', 'icon': Icons.handshake},
        {'text': 'I Like This Topic', 'icon': Icons.favorite},
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

  void _showSchoolItemDetails(int index) {
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
                      _schoolItems[index]['color'].withOpacity(0.5),
                      _schoolItems[index]['color'].withOpacity(0.3),
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
                          tag: 'school-${_schoolItems[index]['title']}',
                          child: Image.asset(
                            _schoolItems[index]['image'],
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
                          color: _schoolItems[index]['color'],
                        ),
                        onPressed: () => _speak(_schoolItems[index]['title']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // School item title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _schoolItems[index]['title'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _schoolItems[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _schoolItems[index]['phrases'].length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (ctx, i) => SizedBox(height: 12),
                  itemBuilder: (ctx, phraseIndex) {
                    final phrase = _schoolItems[index]['phrases'][phraseIndex];
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
                                    color: _schoolItems[index]['color']
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    phrase['icon'],
                                    color: _schoolItems[index]['color'],
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
                                    color: _schoolItems[index]['color'],
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
                    backgroundColor: _schoolItems[index]['color'],
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
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text(
          'School',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                          'School',
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
                            Navigator.pushNamed(context, SchoolTest.routeName);
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
                        itemCount: _schoolItems.length,
                        itemBuilder: (ctx, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: InkWell(
                              onTap: () {
                                _speak(_schoolItems[index]['title']);
                                _showSchoolItemDetails(index);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _schoolItems[index]['color'],
                                      _schoolItems[index]['color'].withOpacity(
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
                                          'school-${_schoolItems[index]['title']}',
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
                                            _schoolItems[index]['image'],
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      _schoolItems[index]['title'],
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
                  'Conversations',
                  'assets/image/conversation.png',
                  Color.fromRGBO(248, 187, 208, 1),
                  () {
                    Navigator.pushNamed(context, ConversationScreen.routeName);
                  },
                ),
                _buildNavButton(
                  context,
                  'Animals',
                  'assets/image/animals.png',
                  Colors.orangeAccent,
                  () {
                    Navigator.pushNamed(context, AnimalScreen.routeName);
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
