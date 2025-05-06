import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'activity_test.dart';

class ActivityScreen extends StatefulWidget {
  static const String routeName = '/activity-screen';
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'Talking',
      'image': 'assets/image/talking.png',
      'color': Color(0xFFF06292), // Pink
      'phrases': [
        {'text': 'I Like Talking', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Talking', 'icon': Icons.thumb_down},
        {'text': 'Do You Want to Talk With Me?', 'icon': Icons.question_answer},
      ],
    },
    {
      'title': 'Running',
      'image': 'assets/image/running.png',
      'color': Color(0xFF4FC3F7), // Blue
      'phrases': [
        {'text': 'I Like Running', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Running', 'icon': Icons.thumb_down},
        {'text': 'Do You Want to Go Running?', 'icon': Icons.question_answer},
      ],
    },
    {
      'title': 'Reading',
      'image': 'assets/image/reading.png',
      'color': Color(0xFF9575CD), // Purple
      'phrases': [
        {'text': 'I Like Reading', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Reading', 'icon': Icons.thumb_down},
        {
          'text': 'Do You Want to Read Together?',
          'icon': Icons.question_answer,
        },
      ],
    },
    {
      'title': 'Drawing',
      'image': 'assets/image/drawing.png',
      'color': Color(0xFF81C784), // Green
      'phrases': [
        {'text': 'I Like Drawing', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Drawing', 'icon': Icons.thumb_down},
        {
          'text': 'Do You Want to Draw Together?',
          'icon': Icons.question_answer,
        },
      ],
    },
    {
      'title': 'Swimming',
      'image': 'assets/image/swimming.png',
      'color': Color(0xFFFFB74D), // Orange
      'phrases': [
        {'text': 'I Like Swimming', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Swimming', 'icon': Icons.thumb_down},
        {'text': 'Do You Want to Go Swimming?', 'icon': Icons.question_answer},
      ],
    },
    {
      'title': 'Basketball',
      'image': 'assets/image/basketball.png',
      'color': Color(0xFFE57373), // Red
      'phrases': [
        {'text': 'I Like Basketball', 'icon': Icons.favorite},
        {'text': 'I Don\'t Like Basketball', 'icon': Icons.thumb_down},
        {
          'text': 'Do You Want to Play Basketball?',
          'icon': Icons.question_answer,
        },
      ],
    },
  ];

  late FlutterTts flutterTts;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
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

  void _showActivityDetails(int index) {
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
                      _activities[index]['color'].withOpacity(0.5),
                      _activities[index]['color'].withOpacity(0.3),
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
                          tag: 'activity-${_activities[index]['title']}',
                          child: Image.asset(
                            _activities[index]['image'],
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
                          color: _activities[index]['color'],
                        ),
                        onPressed: () => _speak(_activities[index]['title']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Activity title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _activities[index]['title'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _activities[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _activities[index]['phrases'].length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (ctx, i) => SizedBox(height: 12),
                  itemBuilder: (ctx, phraseIndex) {
                    final phrase = _activities[index]['phrases'][phraseIndex];
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
                                    color: _activities[index]['color']
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    phrase['icon'],
                                    color: _activities[index]['color'],
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
                                    color: _activities[index]['color'],
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
                    backgroundColor: _activities[index]['color'],
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
          'Activities',
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
          // Header section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    'Choose an Activity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.quiz, size: 18, color: Colors.white),
                  label: Text(
                    'Take a Test',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Navigate to the test screen
                    Navigator.pushNamed(context, ActivityTest.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              ],
            ),
          ),

          // Activities grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemCount: _activities.length,
                itemBuilder: (ctx, index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: InkWell(
                      onTap: () {
                        _speak(_activities[index]['title']);
                        _showActivityDetails(index);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _activities[index]['color'],
                              _activities[index]['color'],
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
                              tag: 'activity-${_activities[index]['title']}',
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
                                    _activities[index]['image'],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              _activities[index]['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
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
    );
  }
}
