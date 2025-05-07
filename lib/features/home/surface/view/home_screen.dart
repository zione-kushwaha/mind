import 'package:abc/features/home/AAC/UI/locked/screens/home_screen.dart';
import 'package:abc/features/home/Emotion/src/ui/pages/game/Emotion_view.dart';
import 'package:abc/features/home/learn/learn_alphabets/view/learn_alphabet_view.dart';
import 'package:abc/features/home/learn/memory_game/homepage.dart';
import 'package:abc/features/home/learn_time/StartClock.dart';
import 'package:abc/features/home/major_learn/view/content.dart';
import 'package:abc/previous/orientation_test/view/orientation_view.dart';
import 'package:abc/previous/practice_speaking/view/practice_speaking.dart';
import 'package:abc/previous/text_reconization/view/text_view.dart';
import 'package:abc/tab/game/view.dart';
import 'package:abc/tab/task/task_view/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../../AAC/models/data/data.dart';
import '../../AAC/models/data/jsonString.dart';

class ChildHomeScreen extends StatefulWidget {
  static const String routeName = '/child_home_screen';
  @override
  _ChildHomeScreenState createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
  int _selectedIndex = 0;

  // Categories of activities
  final List<Map<String, dynamic>> _activityCategories = [
    {
      'title': 'Learning Time',
      'icon': Icons.lightbulb,
      'color': Color.fromARGB(255, 117, 183, 205), // Purple
      'image': 'assets/word_builder.png',
      'subtitle': 'Learn with fun',
    },
    {
      'title': 'Alphabet Fun',
      'icon': Icons.abc,
      'color': Color(0xFFF06292), // Pink
      'image': 'assets/alphabet.png',
      'subtitle': 'Learn letters with sounds!',
    },

    {
      'title': 'AAC Words',
      'icon': Icons.text_fields,
      'color': Color(0xFF9575CD),
      'image': 'assets/word_builder.png',
      'subtitle': 'Understand words better!',
    },
    {
      'title': 'Speaking Practice',
      'icon': Icons.mic,
      'color': Color(0xFF4FC3F7), // Blue
      'image': 'assets/reading.png',
      'subtitle': 'Enjoy fun stories!',
    },
    {
      'title': 'Memory Game',
      'icon': Icons.memory,
      'color': Color(0xFF81C784), // Green
      'image': 'assets/listening.png',
      'subtitle': 'Sharpen your memory!',
    },
    {
      'title': 'Emotions',
      'icon': Icons.emoji_emotions,
      'color': Color(0xFFFFB74D), // Orange
      'image': 'assets/social.png',
      'subtitle': 'learn Emotions ',
    },
    {
      'title': 'Time',
      'icon': Icons.lock_clock,
      'color': Color(0xFFAED581), // Light Green
      'image': 'assets/calm.png',
      'subtitle': 'Learn about time!',
    },
  ];

  // Daily featured activities
  final List<Map<String, dynamic>> _featuredActivities = [
    {
      'title': 'Comfort Reading',
      'description': 'Trace letters with fun',
      'color': Color(0xFFF48FB1),
      'image': 'assets/tracing.png',
    },
    {
      'title': 'Orientation Game',
      'description': 'learn letter with fun',
      'color': Color(0xFFCE93D8), // Light Purple
      'image': 'assets/match.png',
    },
    {
      'title': 'Memory Game',
      'description': 'Boost Your Memory',
      'color': Color(0xFF90CAF9),
      'image': 'assets/story.png',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA), // Light background
      appBar: AppBar(
        title: Text(
          'Mind Bridge',
          style: TextStyle(
            fontFamily: 'OpenDyslexic',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF5D9CEC), // Bright blue
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body:
          _selectedIndex != 0
              ? TaskView()
              : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Banner
                      _buildWelcomeBanner(),

                      SizedBox(height: 20),

                      // Featured Activities Carousel
                      Text(
                        'Special Features',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenDyslexic',
                          color: Color(0xFF5D9CEC),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildFeaturedActivities(),

                      SizedBox(height: 20),

                      // All Activities Grid
                      Text(
                        'Learning Activities',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenDyslexic',
                          color: Color(0xFF5D9CEC),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildActivityGrid(),

                      SizedBox(height: 20),

                      // Fun Characters Section
                      _buildFunCharacters(),
                    ],
                  ),
                ),
              ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Songs'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: TextStyle(fontFamily: 'OpenDyslexic'),
        unselectedLabelStyle: TextStyle(fontFamily: 'OpenDyslexic'),
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 66, 166, 248),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange, // Bright orange background
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Super Learner!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenDyslexic',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedActivities() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _featuredActivities.length,
        itemBuilder: (context, index) {
          final activity = _featuredActivities[index];
          return InkResponse(
            onTap: () {
              // Navigate to activity details
              if (activity['title'] == 'Comfort Reading') {
                Navigator.pushNamed(context, TextReconization.routeName);
              } else if (activity['title'] == 'Orientation Game') {
                Navigator.pushNamed(context, OrientationView.routeName);
              } else if (activity['title'] == 'Memory Game') {
                Navigator.pushNamed(context, MemoryHomePage.routeName);
              }
            },
            child: Container(
              width: 200,
              margin: EdgeInsets.only(right: 12),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: activity['color'],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        // child: Image.asset(
                        //   activity['image'],
                        //   width: 60,
                        //   height: 60,
                        // ),
                        child: Icon(Icons.star, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      FittedBox(
                        child: Text(
                          activity['title'],
                          style: TextStyle(
                            fontFamily: 'OpenDyslexic',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      FittedBox(
                        child: Text(
                          activity['description'],
                          style: TextStyle(
                            fontFamily: 'OpenDyslexic',
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Center(
                          child: Text(
                            'Let\'s Go!',
                            style: TextStyle(
                              fontFamily: 'OpenDyslexic',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: _activityCategories.length,
      itemBuilder: (context, index) {
        final category = _activityCategories[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: category['color'],
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              // Navigate to activity category
              if (category['title'] == 'Learning Time') {
                Navigator.pushNamed(context, ContentScreenLearning.routeName);
              } else if (category['title'] == 'Alphabet Fun') {
                Navigator.pushNamed(context, LearnAlphabetView.routeName);
              } else if (category['title'] == "AAC Words") {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return HomeScreen(
                        data: getData(jsonString).folders!,
                        boardId: 'root',
                      );
                    },
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              } else if (category['title'] == "Speaking Practice") {
                Navigator.pushNamed(context, PracticeSpeaking.routeName);
              } else if (category['title'] == "Listening Games") {
                Navigator.pushNamed(context, ContentScreenLearning.routeName);
              } else if (category['title'] == "Social Stories") {
                Navigator.pushNamed(context, ContentScreenLearning.routeName);
              } else if (category['title'] == "Calm Corner") {
                Navigator.pushNamed(context, ContentScreenLearning.routeName);
              } else if (category['title'] == "Memory Game") {
                Navigator.pushNamed(context, MemoryHomePage.routeName);
              } else if (category['title'] == "Emotions") {
                Navigator.pushNamed(context, EmotionView.routeName);
              } else if (category['title'] == "Time") {
                Navigator.pushNamed(context, StartClock.routeName);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(category['icon'], size: 40, color: Colors.white),
                  SizedBox(height: 5),
                  FittedBox(
                    child: Text(
                      category['title'],
                      style: TextStyle(
                        fontFamily: 'OpenDyslexic',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 4),
                  FittedBox(
                    child: Text(
                      category['subtitle'],
                      style: TextStyle(
                        fontFamily: 'OpenDyslexic',
                        // fontSize: 12,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFunCharacters() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meet Your Learning Friends',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenDyslexic',
              color: Color(0xFF5D9CEC),
            ),
          ),
          SizedBox(height: 12),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCharacterCircle('assets/character1.png', 'Ally'),
                _buildCharacterCircle('assets/character2.png', 'Buddy'),
                _buildCharacterCircle('assets/character3.png', 'Charlie'),
                _buildCharacterCircle('assets/character4.png', 'Daisy'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterCircle(String imagePath, String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue[100],
            // child: Image.asset(imagePath, width: 60, height: 60),
            child: Icon(Icons.child_care, size: 60, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'OpenDyslexic',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
