import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    GameController controller = Get.find<GameController>();
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: IconButton(
        onPressed: () => controller.showMenu(),
        icon: Icon(
          Icons.menu,
          size: 35,
          color: Colors.teal[900],
        ),
      ),
    );
  }
}
