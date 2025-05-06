import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class AnimalTest extends StatefulWidget {
  static const String routeName = '/animal_test';
  const AnimalTest({Key? key}) : super(key: key);

  @override
  _AnimalTestState createState() => _AnimalTestState();
}

class _AnimalTestState extends State<AnimalTest>
    with SingleTickerProviderStateMixin {
  GlobalKey<_WordFindWidgetState> globalKey = GlobalKey();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<WordFindQues> listQuestions = [
    WordFindQues(
      question: "What is this animal name?",
      answer: "dog",
      image: "assets/image/dog.png",
    ),
    WordFindQues(
      question: "What is this animal name?",
      answer: "cat",
      image: "assets/image/cat.png",
    ),
    WordFindQues(
      question: "What is this animal name?",
      answer: "rabbit",
      image: "assets/image/rabbit.png",
    ),
    WordFindQues(
      question: "What is this animal name?",
      answer: "kangaroo",
      image: "assets/image/kangaroo.png",
    ),
    WordFindQues(
      question: "What is this animal name?",
      answer: "giraffe",
      image: "assets/image/giraffe.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text(
          'Animal Test',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: WordFindWidget(
                    key: globalKey,
                    constraints.biggest,
                    listQuestions.map((ques) => ques.clone()).toList(),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                globalKey.currentState?.generatePuzzle(
                  loop: listQuestions.map((ques) => ques.clone()).toList(),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text("New Game"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WordFindWidget extends StatefulWidget {
  final Size size;
  final List<WordFindQues> listQuestions;

  const WordFindWidget(this.size, this.listQuestions, {Key? key})
    : super(key: key);

  @override
  _WordFindWidgetState createState() => _WordFindWidgetState();
}

class _WordFindWidgetState extends State<WordFindWidget> {
  late Size size;
  late List<WordFindQues> listQuestions;
  int indexQues = 0;
  int hintCount = 0;
  late FlutterTts flutterTts;
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    size = widget.size;
    listQuestions = widget.listQuestions;
    generatePuzzle();
    initTts();
    _speak("Welcome to the animal test");
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WordFindQues currentQues = listQuestions[indexQues];
    final theme = Theme.of(context);

    return Column(
      children: [
        // Header with question and controls
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.orange,
                    onPressed: () => generatePuzzle(left: true),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    color: Colors.orange,
                    onPressed: () => generatePuzzle(next: true),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      currentQues.question ?? '',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.orange[900],
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _speak(currentQues.question ?? ''),
                    icon: Icon(Icons.volume_up, color: Colors.orange[700]),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Image section
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child:
                  currentQues.image != null
                      ? Image.asset(currentQues.image!, fit: BoxFit.contain)
                      : const Center(child: Text('No image')),
            ),
          ),
        ),

        // Answer slots
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            runSpacing: 5,
            children:
                currentQues.puzzles.map((puzzle) {
                  Color backgroundColor;
                  if (currentQues.isDone) {
                    backgroundColor = Colors.green[300]!;
                  } else if (puzzle.hintShow) {
                    backgroundColor = Colors.yellow[200]!;
                  } else if (currentQues.isFull) {
                    backgroundColor = Colors.red[300]!;
                  } else {
                    backgroundColor = Colors.orange[100]!;
                  }

                  return InkWell(
                    onTap: () {
                      if (puzzle.hintShow || currentQues.isDone) return;
                      currentQues.isFull = false;
                      puzzle.clearValue();
                      setState(() {});
                    },
                    child: Container(
                      width: 30,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          (puzzle.currentValue ?? '').toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),

        // Letter buttons
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: currentQues.arrayBtns?.length ?? 0,
              itemBuilder: (context, index) {
                bool isUsed = currentQues.puzzles.any(
                  (puzzle) => puzzle.currentIndex == index,
                );

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isUsed ? Colors.grey[300] : Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  onPressed: isUsed ? null : () => setBtnClick(index),
                  child: Text(
                    (currentQues.arrayBtns?[index] ?? '').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Bottom controls
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () => generateHint(),
                icon: const Icon(Icons.lightbulb_outline),
                label: const Text('Hint'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _speak(currentQues.answer ?? ''),
                icon: const Icon(Icons.volume_up),
                label: const Text('Hear Answer'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void generatePuzzle({
    List<WordFindQues>? loop,
    bool next = false,
    bool left = false,
  }) {
    if (loop != null) {
      indexQues = 0;
      listQuestions = <WordFindQues>[];
      listQuestions.addAll(loop);
    } else {
      if (next && indexQues < listQuestions.length - 1) {
        indexQues++;
      } else if (left && indexQues > 0) {
        indexQues--;
      } else if (indexQues >= listQuestions.length - 1) {
        return;
      }

      setState(() {});

      if (listQuestions[indexQues].isDone) return;
    }

    WordFindQues currentQues = listQuestions[indexQues];

    // Generate the puzzle letters
    List<String> answerLetters = currentQues.answer!.split('');
    List<String> extraLetters = _generateExtraLetters(answerLetters.length);

    // Combine answer letters with extra letters and shuffle
    currentQues.arrayBtns = [...answerLetters, ...extraLetters]..shuffle();

    if (!currentQues.isDone) {
      currentQues.puzzles = List.generate(answerLetters.length, (index) {
        return WordFindChar(correctValue: answerLetters[index]);
      });
    }

    hintCount = 0;
    setState(() {});
  }

  List<String> _generateExtraLetters(int answerLength) {
    const String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    int extraCount = max(12 - answerLength, 0);

    List<String> extraLetters = [];
    for (int i = 0; i < extraCount; i++) {
      extraLetters.add(alphabet[random.nextInt(alphabet.length)]);
    }

    return extraLetters;
  }

  void generateHint() async {
    WordFindQues currentQues = listQuestions[indexQues];
    List<WordFindChar> puzzleNoHints =
        currentQues.puzzles
            .where((puzzle) => !puzzle.hintShow && puzzle.currentIndex == null)
            .toList();

    if (puzzleNoHints.isNotEmpty) {
      hintCount++;
      int indexHint = Random().nextInt(puzzleNoHints.length);
      int countTemp = 0;

      currentQues.puzzles =
          currentQues.puzzles.map((puzzle) {
            if (!puzzle.hintShow && puzzle.currentIndex == null) countTemp++;

            if (indexHint == countTemp - 1) {
              puzzle.hintShow = true;
              puzzle.currentValue = puzzle.correctValue;
              for (int i = 0; i < currentQues.arrayBtns!.length; i++) {
                if (currentQues.arrayBtns![i] == puzzle.correctValue &&
                    !currentQues.puzzles.any((p) => p.currentIndex == i)) {
                  puzzle.currentIndex = i;
                  break;
                }
              }
            }

            return puzzle;
          }).toList();

      if (currentQues.fieldCompleteCorrect()) {
        currentQues.isDone = true;
        setState(() {});

        await Future.delayed(const Duration(seconds: 1));
        generatePuzzle(next: true);
      }

      setState(() {});
    }
  }

  Future<void> setBtnClick(int index) async {
    WordFindQues currentQues = listQuestions[indexQues];
    int currentIndexEmpty = currentQues.puzzles.indexWhere(
      (puzzle) => puzzle.currentValue == null,
    );

    if (currentIndexEmpty >= 0) {
      currentQues.puzzles[currentIndexEmpty].currentIndex = index;
      currentQues.puzzles[currentIndexEmpty].currentValue =
          currentQues.arrayBtns?[index];

      if (currentQues.fieldCompleteCorrect()) {
        currentQues.isDone = true;
        setState(() {});

        await Future.delayed(const Duration(seconds: 1));
        generatePuzzle(next: true);
      }
      setState(() {});
    }
  }

  void initTts() {
    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    flutterTts.setErrorHandler((msg) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  Future _speak(String word) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(word);
  }
}

class WordFindQues {
  String? question;
  String? image;
  String? answer;
  bool isDone = false;
  bool isFull = false;
  List<WordFindChar> puzzles = <WordFindChar>[];
  List<String>? arrayBtns = <String>[];

  WordFindQues({this.image, this.question, this.answer, this.arrayBtns});

  void setWordFindChar(List<WordFindChar> puzzles) => this.puzzles = puzzles;

  void setIsDone() => isDone = true;

  bool fieldCompleteCorrect() {
    bool complete =
        puzzles.where((puzzle) => puzzle.currentValue == null).isEmpty;

    if (!complete) {
      isFull = false;
      return complete;
    }

    isFull = true;
    String answeredString = puzzles
        .map((puzzle) => puzzle.currentValue)
        .join("");
    return answeredString == answer;
  }

  WordFindQues clone() {
    return WordFindQues(answer: answer, image: image, question: question);
  }
}

class WordFindChar {
  String? currentValue;
  int? currentIndex;
  String? correctValue;
  bool hintShow;

  WordFindChar({
    this.hintShow = false,
    this.correctValue,
    this.currentIndex,
    this.currentValue,
  });

  getCurrentValue() {
    if (correctValue != null) {
      return currentValue;
    } else if (hintShow) {
      return correctValue;
    }
  }

  void clearValue() {
    currentIndex = null;
    currentValue = null;
  }
}
