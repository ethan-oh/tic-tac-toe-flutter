import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';

class PlayerInfo extends StatelessWidget {
  final bool isPlayerOne;

  const PlayerInfo({super.key, required this.isPlayerOne});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => Container(
        width: (kIsWeb) ? Get.width / 2.5 : Get.width / 2,
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          elevation: 0,
          color: controller.isPlayerOneTurn == isPlayerOne
              ? Colors.white
              : Colors.black.withOpacity(0.05),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  isPlayerOne ? 'Player 1' : 'Player 2',
                  style: settingTitleStyle,
                ),
              ),
              ElevatedButton(
                onPressed: (isPlayerOne)
                    ? controller.isPlayerOneBacksiesButtonDisable ||
                            controller.isGameFinish
                        ? null
                        : () => controller.playerOneBacksiesButtonAction()
                    : controller.isPlayerTwoBacksiesButtonDisable ||
                            controller.isGameFinish
                        ? null
                        : () => controller.playerTwoBacksiesButtonAction(),
                child: const Text('무르기'),
              ),
              Text(
                '남은 횟수 : ${isPlayerOne ? controller.playerOneBackCount : controller.playerTwoBackCount}',
                style: smallTextStyle,
              ),
              Icon(
                isPlayerOne
                    ? controller.playerOneMarker
                    : controller.playerTwoMarker,
                color: isPlayerOne
                    ? controller.playerOneColor
                    : controller.playerTwoColor,
                size: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
