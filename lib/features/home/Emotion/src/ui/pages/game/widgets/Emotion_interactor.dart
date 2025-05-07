import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/local/colors.dart';
import '../controller/game_controller.dart';

class EmotionInteractor extends StatelessWidget {
  const EmotionInteractor();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: lightColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = context.watch<GameController>();
          final state = controller.state;
          final puzzle = state.puzzle;

          return Stack(
            children:
                puzzle.tiles
                    .map(
                      (e) => Image.asset(
                        puzzle.image.gifPath,
                        fit: BoxFit.cover,
                        height: 400,
                      ),
                    )
                    .toList(),
          );
        },
      ),
    );
  }
}
