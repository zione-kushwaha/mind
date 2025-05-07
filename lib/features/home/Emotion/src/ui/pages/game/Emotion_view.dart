import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/local/component.dart';
import '../../utils/responsive.dart';
import 'controller/game_controller.dart';
import 'widgets/Emotion_interactor.dart';
import 'widgets/Emotion_options.dart';

class EmotionView extends StatefulWidget {
  static const String routeName = '/emotion_view';
  const EmotionView({super.key});

  @override
  State<EmotionView> createState() => _EmotionViewState();
}

class _EmotionViewState extends State<EmotionView> {
  var player = AudioCache();

  @override
  void initState() {
    super.initState();
    player.loadPath("sounds/start.mp3");
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final width = responsive.width;
    return ChangeNotifierProvider(
      create: (_) {
        final controller = GameController();
        controller.onFinish.listen((_) {});
        return controller;
      },
      builder:
          (context, child) => RawKeyboardListener(
            autofocus: true,
            includeSemantics: false,
            focusNode: FocusNode(),
            child: child ?? SizedBox.shrink(),
          ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: OrientationBuilder(
            builder: (_, orientation) {
              final isPortrait = orientation == Orientation.portrait;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustombackAppBar(context, () {
                    Navigator.pop(context);
                  }),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (_, constraints) {
                        final height = constraints.maxHeight;
                        (isPortrait ? height * 0.45 : height * 0.5)
                            .clamp(250, 700)
                            .toDouble();
                        final optionsHeight =
                            (isPortrait ? height * 0.25 : height * 0.2)
                                .clamp(120, 200)
                                .toDouble();

                        return SizedBox(
                          height: height,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: SizedBox(
                                    height: 400,
                                    child: EmotionInteractor(),
                                  ),
                                ),
                                SizedBox(
                                  height: optionsHeight,
                                  child: EmotionOptions(width: width),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
