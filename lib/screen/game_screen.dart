import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/widget/game/game_board.dart';
import 'package:tic_tac_toe_app/widget/home_button.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/widget/game/menu_button.dart';
import 'package:tic_tac_toe_app/screen/menu_screen.dart';
import 'package:tic_tac_toe_app/widget/game/player_info.dart';

class GameScreen extends GetView<GameController> {
  final GameSetting settings;
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
            leading: const MenuButton(),
          ),
          body: const SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlayerInfo(isPlayerOne: true),
                      PlayerInfo(isPlayerOne: false),
                    ],
                  ),
                  GameBoard(),
                ],
              ),
            ),
          ),
        ),
        const MenuScreen(),
      ],
    );
  }
}
