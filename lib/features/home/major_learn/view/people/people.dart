import 'package:abc/features/home/major_learn/view/people/people_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PeopleScreen extends StatefulWidget {
  static const String routeName = '/people';
  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _peopleList = [
    {
      'title': 'Mother',
      'image': 'assets/image/mother.png',
      'color': Color(0xFFF06292), // Pink
      'phrases': [
        {'text': 'Mommy!', 'icon': Icons.favorite},
        {'text': 'I Love My Mother', 'icon': Icons.favorite},
        {'text': 'I Love You Mom', 'icon': Icons.favorite},
        {'text': 'I Miss My Mom', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Father',
      'image': 'assets/image/dad.png',
      'color': Color(0xFF4FC3F7), // Blue
      'phrases': [
        {'text': 'Daddy!', 'icon': Icons.favorite},
        {'text': 'I Love My Father', 'icon': Icons.favorite},
        {'text': 'I Love You Dad', 'icon': Icons.favorite},
        {'text': 'I Miss My Dad', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Grand Parents',
      'image': 'assets/image/grand parents.png',
      'color': Color(0xFF9575CD), // Purple
      'phrases': [
        {'text': 'I Love My Grand Parents', 'icon': Icons.favorite},
        {'text': 'I Love You Grand Parents', 'icon': Icons.favorite},
        {'text': 'I Miss My Grand Parents', 'icon': Icons.favorite},
        {'text': 'They Are My Grand Parents', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Sister',
      'image': 'assets/image/sister.png',
      'color': Color(0xFF81C784), // Green
      'phrases': [
        {'text': 'I Love My Sister', 'icon': Icons.favorite},
        {'text': 'I Love You Sister', 'icon': Icons.favorite},
        {'text': 'I Miss My Sister', 'icon': Icons.favorite},
        {'text': 'She Is My Sister', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Brother',
      'image': 'assets/image/brother.png',
      'color': Color(0xFFFFB74D), // Orange
      'phrases': [
        {'text': 'I Love My Brother', 'icon': Icons.favorite},
        {'text': 'I Love You Brother', 'icon': Icons.favorite},
        {'text': 'I Miss My Brother', 'icon': Icons.favorite},
        {'text': 'He Is My Brother', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Aunt',
      'image': 'assets/image/aunt.png',
      'color': Color(0xFFE57373), // Red
      'phrases': [
        {'text': 'I Love My Aunt', 'icon': Icons.favorite},
        {'text': 'I Love You Aunt', 'icon': Icons.favorite},
        {'text': 'I Miss My Aunt', 'icon': Icons.favorite},
        {'text': 'She Is My Aunt', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Uncle',
      'image': 'assets/image/uncle.png',
      'color': Color(0xFF7986CB), // Indigo
      'phrases': [
        {'text': 'I Love My Uncle', 'icon': Icons.favorite},
        {'text': 'I Love You Uncle', 'icon': Icons.favorite},
        {'text': 'I Miss My Uncle', 'icon': Icons.favorite},
        {'text': 'He Is My Uncle', 'icon': Icons.favorite},
      ],
    },
    {
      'title': 'Parents',
      'image': 'assets/image/parents.png',
      'color': Color(0xFF4DB6AC), // Teal
      'phrases': [
        {'text': 'I Love My Parents', 'icon': Icons.favorite},
        {'text': 'I Miss My Parents', 'icon': Icons.favorite},
        {'text': 'They Are My Parents', 'icon': Icons.favorite},
        {'text': 'Can You Help Me Find My Parents?', 'icon': Icons.help},
      ],
    },
    {
      'title': 'Teacher',
      'image': 'assets/image/teacher2.png',
      'color': Color(0xFFBA68C8), // Deep Purple
      'phrases': [
        {'text': 'I Love My Teacher', 'icon': Icons.favorite},
        {'text': 'I Love You Teacher', 'icon': Icons.favorite},
        {'text': 'I Miss My Teacher', 'icon': Icons.favorite},
        {'text': 'She Is My Teacher', 'icon': Icons.favorite},
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

  void _showPersonDetails(int index) {
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
                      _peopleList[index]['color'].withOpacity(0.5),
                      _peopleList[index]['color'].withOpacity(0.3),
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
                          tag: 'person-${_peopleList[index]['title']}',
                          child: Image.asset(
                            _peopleList[index]['image'],
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
                        onPressed: () => _speak(_peopleList[index]['title']),
                        elevation: 2,
                        mini: true,
                        child: Icon(
                          Icons.volume_up,
                          color: _peopleList[index]['color'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Person title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  _peopleList[index]['title'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _peopleList[index]['color'],
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Phrases list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _peopleList[index]['phrases'].length,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (ctx, i) => SizedBox(height: 12),
                  itemBuilder: (ctx, phraseIndex) {
                    final phrase = _peopleList[index]['phrases'][phraseIndex];
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
                                    color: _peopleList[index]['color']
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    phrase['icon'],
                                    color: _peopleList[index]['color'],
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
                                    color: _peopleList[index]['color'],
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
                    backgroundColor: _peopleList[index]['color'],
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
          'People',
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
                    'Choose a Person',
                    style: TextStyle(
                      fontSize: 18,
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
                    Navigator.pushNamed(context, PeopleTest.routeName);
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

          // People grid
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
                itemCount: _peopleList.length,
                itemBuilder: (ctx, index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: InkWell(
                      onTap: () {
                        _speak(_peopleList[index]['title']);
                        _showPersonDetails(index);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _peopleList[index]['color'],
                              _peopleList[index]['color'].withOpacity(0.8),
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
                              tag: 'person-${_peopleList[index]['title']}',
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
                                    _peopleList[index]['image'],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              _peopleList[index]['title'],
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
    );
  }
}
