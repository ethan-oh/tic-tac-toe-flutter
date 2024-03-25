import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/common/font_style.dart';

Widget playerOneInfo({required Color color}) {
  GameController controller = Get.find<GameController>();
  return Container(
    width: (kIsWeb) ? Get.width / 2.5 : Get.width / 2,
    constraints: const BoxConstraints(maxWidth: 300),
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Card(
      elevation: 0,
      color: color,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Player 1',
              style: AppStyle.settingTitleStyle,
            ),
          ),
          GetBuilder<GameController>(
            builder: (controller) => ElevatedButton(
              onPressed: controller.isPlayerOneBacksiesButtonDisable ||
                      controller.isGameFinish()
                  ? null
                  : () => controller.playerOneBacksiesButtonAction(),
              child: const Text('무르기'),
            ),
          ),
          Text('남은 횟수 : ${controller.playerOneBackCount}'),
          Icon(
            controller.playerOneMarker,
            color: controller.playerOneColor,
            size: 70,
          ),
        ],
      ),
    ),
  );
}

Widget playerTwoInfo({required Color color}) {
  GameController controller = Get.find<GameController>();
  return Container(
    width: (kIsWeb) ? Get.width / 2.5 : Get.width / 2,
    constraints: const BoxConstraints(maxWidth: 300),
    padding: const EdgeInsets.symmetric(vertical: 10),
    // color: color,
    child: Card(
      elevation: 0,
      color: color,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Player 2',
              style: AppStyle.settingTitleStyle,
            ),
          ),
          GetBuilder<GameController>(
            builder: (controller) => ElevatedButton(
              onPressed: controller.isPlayerTwoBacksiesButtonDisable ||
                      controller.isGameFinish()
                  ? null
                  : () => controller.playerTwoBacksiesButtonAction(),
              child: const Text('무르기'),
            ),
          ),
          Text('남은 횟수 : ${controller.playerTwoBackCount}'),
          Icon(
            controller.playerTwoMarker,
            color: controller.playerTwoColor,
            size: 70,
          ),
        ],
      ),
    ),
  );
}
