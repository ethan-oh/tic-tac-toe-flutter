import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/%08common/font_style.dart';

Widget playerOneInfo({required Color color}) {
  GameController controller = Get.find<GameController>();
  return Container(
    width: 170,
    padding: const EdgeInsets.symmetric(vertical: 10),
    margin: const EdgeInsets.all(10),
    color: color,
    child: Column(
      children: [
        const Text(
          'Player 1',
          style: AppStyle.settingTitleStyle,
        ),
        GetBuilder<GameController>(
          builder: (controller) => ElevatedButton(
            onPressed: controller.isPlayerOneBacksiesButtonDisable
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
  );
}

Widget playerTwoInfo({required Color color}) {
  GameController controller = Get.find<GameController>();
  return Container(
    width: 170,
    padding: const EdgeInsets.symmetric(vertical: 10),
    margin: const EdgeInsets.all(10),
    color: color,
    child: Column(
      children: [
        const Text(
          'Player 2',
          style: AppStyle.settingTitleStyle,
        ),
        GetBuilder<GameController>(
          builder: (controller) => ElevatedButton(
            onPressed: controller.isPlayerTwoBacksiesButtonDisable
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
  );
}
