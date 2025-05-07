import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../../../previous/orientation_test/view/orientation_view.dart';
import '../../../../../previous/pallete_generator/repository.dart';
import '../../../../../previous/practice_speaking/view/practice_speaking.dart';
import '../repository/character_image_provider.dart';
import '../repository/character_notifier.dart';

class LearnAlphabetView extends ConsumerStatefulWidget {
  static const String routeName = '/learnAlphabetView';
  @override
  _LearnAlphabetViewState createState() => _LearnAlphabetViewState();
}

class _LearnAlphabetViewState extends ConsumerState<LearnAlphabetView> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speak(ref.read(characterProvider));
    });
  }

  void _speak(String text) async {
    await flutterTts.speak('This is Alphabet $text');
  }

  void _onNext() {
    ref.read(characterProvider.notifier).nextCharacter();
    final newChar = ref.read(characterProvider);
    _speak(newChar);
  }

  void _onPrevious() {
    ref.read(characterProvider.notifier).previousCharacter();
    final newChar = ref.read(characterProvider);
    _speak(newChar);
  }

  @override
  Widget build(BuildContext context) {
    final currentChar = ref.watch(characterProvider);
    final isFirstLetter =
        currentChar == 'a'; // Assuming 'A' is the first character
    final characterImageAsyncValue = ref.watch(
      characterImageProvider(currentChar),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      body: characterImageAsyncValue.when(
        data: (characterImageResponse) {
          final characterImageUrl =
              characterImageResponse.characterImageUrl ?? '';
          final imageData = characterImageResponse.images?.first;

          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'LEARN ALPHABETS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Stack(
                children: [
                  Center(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final colorProvider = ref.watch(
                          paletteGeneratorProvider(characterImageUrl),
                        );
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: colorProvider.value,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.4,
                    top: 0,
                    child: Row(
                      children: [
                        Image.network(
                          imageData?.imageUrl ?? '',
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: MediaQuery.of(context).size.width * 0.25,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(800),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    child: FittedBox(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            imageData?.description ?? '',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Back button (only visible when not on first letter)
                  if (!isFirstLetter)
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      child: TextButton(
                        onPressed: _onPrevious,
                        child: Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                  if (!isFirstLetter) SizedBox(width: 20),

                  Image.network(
                    characterImageUrl,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),

                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: TextButton(
                      onPressed: _onNext,
                      child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _speak(currentChar),
                child: Image.asset(
                  'assets/first/15.png',
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrientationView(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/first/10.png',
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                  SizedBox(width: 80),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeSpeaking(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/first/4.png',
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
