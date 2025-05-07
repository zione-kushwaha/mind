import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../../models/data/data.dart';
import '../../../providers/locked/dialog.dart';
import '../../../providers/locked/home.dart';
import '../../../stylesheets/constants.dart';
import '../widgets/expand_text_screen.dart';
import '../widgets/folderWidget.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/sentence_bar.dart';
import '../widgets/tileWidget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen_route";
  final Map<String, FolderModel> data;
  final String boardId;

  const HomeScreen({required this.data, required this.boardId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum TtsState { playing, stopped }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  void initTts() {
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

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  @override
  void initState() {
    _scrollController =
        ScrollController()..addListener(() {
          setState(() {
            _scrollOffset = _scrollController.offset;
          });
        });
    initTts();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final dialologModel = Provider.of<DialogModel>(context);
    final homeModel = Provider.of<HomeModel>(context);
    final FolderModel folderModel = widget.data[widget.boardId]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height * 0.2),
        child: Container(
          margin: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: SentenceBar(
                  tapped: () => _speak(homeModel.getFullSent()),
                ),
              ),
              Expanded(flex: 2, child: MainAppBar(scrollOffset: _scrollOffset)),
            ],
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 7.0),
        physics: const BouncingScrollPhysics(),
        itemCount: folderModel.subItems.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return TileWidget(
              labelPos: dialologModel.tileLabelTop,
              text: "Add text",
              content: 'assets/symbols/mulberry/a_-_lower_case.svg',
              color: soft_green,
              tapped:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExpandTextScreen()),
                  ),
            );
          } else {
            final TileModel tileInfo = folderModel.subItems[index - 1];
            String title = tileInfo.labelKey.split('.').last;
            if (tileInfo.loadBoard == null) {
              return TileWidget(
                labelPos: dialologModel.tileLabelTop,
                text: title,
                content: 'assets' + (tileInfo.image ?? '/default_image.png'),
                color: dialologModel.tileBackgroundColor,
                labelColor: dialologModel.tileTextColor,
                tapped: () {
                  _speak(title);
                  setState(() {
                    homeModel.addWords(tileInfo);
                  });
                },
              );
            } else {
              return FolderWidget(
                text: title,
                content: 'assets' + (tileInfo.image ?? '/default_image.png'),
                boardId: tileInfo.loadBoard!,
                color: dialologModel.folderBackgroundColor,
                labelColor: dialologModel.folderTextColor,
                labelPos: dialologModel.folderLabelTop,
              );
            }
          }
        },
      ),
    );
  }
}
