import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/button.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/view/game/game_board.dart';
import 'package:tic_tac_toe_app/view/game/menu_screen.dart';
import 'package:tic_tac_toe_app/view/game/player_info.dart';

class GameScreen extends GetView<GameController> {
  final SettingModel settings;
  const GameScreen({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              '승리조건: ${controller.alignCount}칸 완성',
            ),
            actions: [
              HomeButton(),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetBuilder<GameController>(
                  builder: (_) => Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        playerOneInfo(
                          color: controller.isPlayerOneTurn
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        playerTwoInfo(
                          color: controller.isPlayerOneTurn
                              ? Colors.transparent
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<GameController>(
                  builder: (_) => gameGridBoard(context),
                ),
              ],
            ),
          ),
        ),
        const MenuScreen(),
      ],
    );
  }
}