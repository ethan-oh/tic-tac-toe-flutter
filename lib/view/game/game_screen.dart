import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/home_button.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/view/game/game_board.dart';
import 'package:tic_tac_toe_app/view/game/menu_button.dart';
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
            actions: const [
              HomeButton(),
            ],
            leading: MenuButton(controller: controller),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _gameInfo(),
                  _board(context),
                ],
              ),
            ),
          ),
        ),
        const MenuScreen(),
      ],
    );
  }

  GetBuilder<GameController> _board(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (_) => gameGridBoard(context),
    );
  }

  GetBuilder<GameController> _gameInfo() {
    return GetBuilder<GameController>(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          playerOneInfo(
            color:
                controller.isPlayerOneTurn ? Colors.white : Colors.black.withOpacity(0.05),
          ),
          playerTwoInfo(
            color:
                controller.isPlayerOneTurn ? Colors.black.withOpacity(0.05) : Colors.white,
          ),
        ],
      ),
    );
  }
}
