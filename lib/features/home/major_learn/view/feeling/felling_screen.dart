import 'package:abc/features/home/learn/activities/view/activities.dart';
import 'package:abc/features/home/major_learn/view/feeling/feeling_test.dart';
import 'package:abc/features/home/major_learn/view/food/food_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FeelingScreen extends StatefulWidget {
  static const String routeName = '/feeling';
  @override
  State<FeelingScreen> createState() => _FeelingScreenState();
}

enum TtsState { playing, stopped }

class _FeelingScreenState extends State<FeelingScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _feelings = [
    {
      'text': 'Happy',
      'image': 'assets/image/happy.png',
      'color': Color(0xFFFFD54F), // Amber
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m Happy',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel Happy',
      'image3': 'assets/image/Ques.png',
      'text3': 'Do You Feel Happy?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'I Want to Feel Happy',
    },
    {
      'text': 'Sad',
      'image': 'assets/image/sad.png',
      'color': Color(0xFF64B5F6), // Blue
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m Sad',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel Sad',
      'image3': 'assets/image/Ques.png',
      'text3': 'Do You Feel Sad?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'I Don\'t Want to Feel Sad',
    },
    {
      'text': 'Exhausted',
      'image': 'assets/image/exhausted.png',
      'color': Color(0xFFA1887F), // Brown
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m Exhausted',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel Exhausted',
      'image3': 'assets/image/Ques.png',
      'text3': 'Do You Feel Exhausted?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'I Don\'t Want to Feel Exhausted',
    },
    {
      'text': 'Relaxed',
      'image': 'assets/image/relaxed.png',
      'color': Color(0xFF81C784), // Green
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m Relaxed',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel Relaxed',
      'image3': 'assets/image/Ques.png',
      'text3': 'Do You Feel Relaxed?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'I Want to Feel Relaxed',
    },
    {
      'text': 'In Love',
      'image': 'assets/image/in love.png',
      'color': Color(0xFFF06292), // Pink
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m In Love',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel In Love',
      'image3': 'assets/image/Ques.png',
      'text3': 'Are You In Love?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'I Want to Fall In Love',
    },
    {
      'text': 'Stressed',
      'image': 'assets/image/stressed.png',
      'color': Color(0xFFE57373), // Red
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m Stressed',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel Stressed',
      'image3': 'assets/image/Ques.png',
      'text3': 'Do You Feel Stressed?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'I Don\'t Want to Feel Stressed',
    },
    {
      'text': 'Thankful',
      'image': 'assets/image/thankful.png',
      'color': Color(0xFFBA68C8), // Purple
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m Thankful',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel Thankful',
      'image3': 'assets/image/Ques.png',
      'text3': 'Do You Feel Thankful?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'I Want to Feel Thankful',
    },
    {
      'text': 'Confused',
      'image': 'assets/image/confused.png',
      'color': Color(0xFF4DB6AC), // Teal
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m Confused',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel Confused',
      'image3': 'assets/image/Ques.png',
      'text3': 'Do You Feel Confused?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'You Are Confusing Me',
    },
    {
      'text': 'Joyful',
      'image': 'assets/image/joyful.png',
      'color': Color(0xFFFF8A65), // Deep Orange
      'image1': 'assets/image/iam.png',
      'text1': 'I\'m Joyful',
      'image2': 'assets/image/feel.png',
      'text2': 'I Feel Joyful',
      'image3': 'assets/image/Ques.png',
      'text3': 'Do You Feel Joyful?',
      'image4': 'assets/image/iwant to.png',
      'text4': 'I Want to Feel Joyful',
    },
  ];

  late FlutterTts flutterTts;
  late AnimationController _animationController;
  late Animation<double> _animation;
  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _initializeTts();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _initializeTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((message) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak(String text) async {
    if (isPlaying) {
      await flutterTts.stop();
    }
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    _animationController.dispose();
    super.dispose();
  }

  void _showFeelingDetails(int index) {
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
                      _feelings[index]['color'].withOpacity(0.5),
                      _feelings[index]['color'].withOpacity(0.3),
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
                          tag: 'feeling-${_feelings[index]['text']}',
                          child: Image.asset(
                            _feelings[index]['image'],
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
                          color: _feelings[index]['color'],
                        ),
                        onPressed: () => _speak(_feelings[index]['text']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Feeling title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _feelings[index]['text'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _feelings[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  physics: BouncingScrollPhysics(),
                  children: [
                    _buildPhraseItem(index, 'image1', 'text1'),
                    SizedBox(height: 12),
                    _buildPhraseItem(index, 'image2', 'text2'),
                    SizedBox(height: 12),
                    _buildPhraseItem(index, 'image3', 'text3'),
                    SizedBox(height: 12),
                    _buildPhraseItem(index, 'image4', 'text4'),
                  ],
                ),
              ),

              // Close button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _feelings[index]['color'],
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

  Widget _buildPhraseItem(int index, String imageKey, String textKey) {
    return ScaleTransition(
      scale: _animation,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _speak(_feelings[index][textKey]),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _feelings[index]['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    _feelings[index][imageKey],
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _feelings[index][textKey],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.volume_up, color: _feelings[index]['color']),
                  onPressed: () => _speak(_feelings[index][textKey]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text(
          'Feelings',
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
                        Row(
                          children: [
                            Text(
                              'Feelings',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _speak('Feelings'),
                              icon: Icon(Icons.volume_up),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  FeelingTest.routeName,
                                );
                              },
                              child: Text(
                                "Take a Test",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, right: 10, left: 10),
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.5,
                                crossAxisCount: 2,
                                mainAxisExtent: 120,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                          itemCount: _feelings.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                _speak(_feelings[index]['text']);
                                _showFeelingDetails(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _feelings[index]['color'].withOpacity(
                                        0.8,
                                      ),
                                      _feelings[index]['color'].withOpacity(
                                        0.6,
                                      ),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        _feelings[index]['image'],
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.contain,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            _feelings[index]['text'],
                                            style: TextStyle(
                                              fontSize: 18,
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
                            );
                          },
                        ),
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
                  'Food',
                  'assets/image/food.png',
                  Colors.greenAccent,
                  () {
                    Navigator.pushNamed(context, FoodScreen.routeName);
                  },
                ),
                _buildNavButton(
                  context,
                  'Activities',
                  'assets/image/activites.png',
                  Colors.lightGreen.shade400,
                  () {
                    Navigator.pushNamed(context, ActivityScreen.routeName);
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
