import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/widget/game/board_box.dart';

Widget gameGridBoard(context) {
  GameController controller = Get.find<GameController>();
  int gridCount = controller.gridCount;
  List<Widget> boxList = [];
  for (int i = 1; i <= controller.gridCount; i++) {
    for (int j = 1; j <= controller.gridCount; j++) {
      boxList.add(
        boardBox(context, i, j, icon: controller.iconList[i - 1][j - 1]),
      );
    }
  }
  double? boardWidth = (kIsWeb) ? (Get.height - 173) * 0.8 : null;
  return SizedBox(
    width: boardWidth,
    height: boardWidth,
    child: GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridCount,),
      children: boxList,
    ),
  );
}
