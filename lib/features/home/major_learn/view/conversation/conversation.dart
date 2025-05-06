import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ConversationScreen extends StatefulWidget {
  static const String routeName = '/conversation-screen';
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

enum TtsState { playing, stopped }

class _ConversationScreenState extends State<ConversationScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _conversations = [
    {
      'text': 'Me',
      'image': 'assets/image/me.png',
      'color': Color(0xFFF06292), // Pink
      'image1': 'assets/image/iwant to.png',
      'text1': 'My Name Is Mickey',
      'image2': 'assets/image/i am.png',
      'text2': 'I\'m Mickey',
      'image3': 'assets/image/do you.png',
      'text3': 'Do You Know My Name?',
      'image4': 'assets/image/Ques.png',
      'text4': 'What Is Your Name?',
    },
    {
      'text': 'Hello',
      'image': 'assets/image/hello.png',
      'color': Color(0xFF4FC3F7), // Blue
      'image1': 'assets/image/hi.png',
      'text1': 'Hello',
      'image2': 'assets/image/hi.png',
      'text2': 'Hi',
      'image3': 'assets/image/hi.png',
      'text3': 'Greetings',
      'image4': 'assets/image/Ques.png',
      'text4': 'How Are You?',
    },
    {
      'text': 'Help',
      'image': 'assets/image/help.png',
      'color': Color(0xFFFFA000), // Amber
      'image1': 'assets/image/help me.png',
      'text1': 'Help Me',
      'image2': 'assets/image/Ques.png',
      'text2': 'Can You Help Me',
      'image3': 'assets/image/need help.png',
      'text3': 'I Need Help',
      'image4': 'assets/image/need help2.png',
      'text4': 'Do You Need Help?',
    },
    {
      'text': 'Yes',
      'image': 'assets/image/yes.png',
      'color': Color(0xFF66BB6A), // Green
      'image1': 'assets/image/yes2.png',
      'text1': 'Yes',
      'image2': 'assets/image/yes please.png',
      'text2': 'Yes Please',
      'image3': 'assets/image/alright.png',
      'text3': 'Alright',
      'image4': 'assets/image/agreed.png',
      'text4': 'Agreed',
    },
    {
      'text': 'No',
      'image': 'assets/image/no.png',
      'color': Color(0xFFEF5350), // Red
      'image1': 'assets/image/no2.png',
      'text1': 'No',
      'image2': 'assets/image/nope.png',
      'text2': 'Nope',
      'image3': 'assets/image/never.png',
      'text3': 'Never',
      'image4': 'assets/image/Ques.png',
      'text4': 'You Don\'t Like It?',
    },
    {
      'text': 'Toilet',
      'image': 'assets/image/toilet.png',
      'color': Color(0xFFAB47BC), // Purple
      'image1': 'assets/image/go toilet.png',
      'text1': 'I Need to GO to The Toilet',
      'image2': 'assets/image/poop.png',
      'text2': 'I Need to Poop',
      'image3': 'assets/image/peed myself.png',
      'text3': 'I Peed Myself',
      'image4': 'assets/image/myself.png',
      'text4': 'I Pooped Myself',
    },
    {
      'text': 'What',
      'image': 'assets/image/what.png',
      'color': Color(0xFF26C6DA), // Cyan
      'image1': 'assets/image/Ques.png',
      'text1': 'What IS That?',
      'image2': 'assets/image/mean.png',
      'text2': 'What Do You Mean?',
      'image3': 'assets/image/explain it.png',
      'text3': 'Can You Explain It?',
      'image4': 'assets/image/repeat.png',
      'text4': 'Can You Repeat What You Said?',
    },
    {
      'text': 'Sleep',
      'image': 'assets/image/sleep.png',
      'color': Color(0xFF5C6BC0), // Indigo
      'image1': 'assets/image/want sleep.png',
      'text1': 'I Want to Sleep',
      'image2': 'assets/image/i dontlike.png',
      'text2': 'I Don\'t Want to Sleep',
      'image3': 'assets/image/im tired.png',
      'text3': 'I\'m Tired',
      'image4': 'assets/image/Ques.png',
      'text4': 'Are You Tired?',
    },
    {
      'text': 'Bath',
      'image': 'assets/image/bath.png',
      'color': Color(0xFF26A69A), // Teal
      'image1': 'assets/image/bath2.png',
      'text1': 'I Want to Take a Bath',
      'image2': 'assets/image/heart.png',
      'text2': 'I Like Taking a Bath',
      'image3': 'assets/image/shower.png',
      'text3': 'I Want to Take a Shower',
      'image4': 'assets/image/wash.png',
      'text4': 'I Want to Wash My Hands',
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

  void _showConversationDetails(int index) {
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
                      _conversations[index]['color'].withOpacity(0.5),
                      _conversations[index]['color'].withOpacity(0.3),
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
                          tag: 'conversation-${_conversations[index]['text']}',
                          child: Image.asset(
                            _conversations[index]['image'],
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
                          color: _conversations[index]['color'],
                        ),
                        onPressed: () => _speak(_conversations[index]['text']),
                        elevation: 2,
                        mini: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Conversation title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _conversations[index]['text'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _conversations[index]['color'],
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
                    backgroundColor: _conversations[index]['color'],
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
          onTap: () => _speak(_conversations[index][textKey]),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _conversations[index]['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    _conversations[index][imageKey],
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _conversations[index][textKey],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.volume_up,
                    color: _conversations[index]['color'],
                  ),
                  onPressed: () => _speak(_conversations[index][textKey]),
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
      appBar: AppBar(
        title: Text(
          'Conversation',
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
                        Row(
                          children: [
                            FittedBox(
                              child: Text(
                                'Conversations',
                                style: TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _speak('Conversations'),
                              icon: Icon(Icons.volume_up),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => ConvTest()),
                                // );
                              },
                              child: FittedBox(
                                child: Text(
                                  "Take a Test",
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                          itemCount: _conversations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                _speak(_conversations[index]['text']);
                                _showConversationDetails(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _conversations[index]['color']
                                          .withOpacity(0.8),
                                      _conversations[index]['color']
                                          .withOpacity(0.6),
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
                                        _conversations[index]['image'],
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.contain,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            _conversations[index]['text'],
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
                  'People',
                  'assets/image/people.png',
                  Colors.lightBlueAccent,
                  () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (ctx) => PeopleScreen()),
                    // );
                  },
                ),
                _buildNavButton(
                  context,
                  'School',
                  'assets/image/school.png',
                  Colors.redAccent,
                  () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (ctx) => SchoolScreen()),
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
