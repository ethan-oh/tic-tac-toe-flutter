import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controllers/game_controller.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.controller,
  });

  final GameController controller;

  @override
  Widget build(BuildContext context) {
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
