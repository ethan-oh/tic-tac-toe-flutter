import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/error_snackbar.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';

Widget boardBox(context, int x, int y, {IconData? icon}) {
  GameController controller = Get.find<GameController>();
  double borderWidth = 10;
  double width =
      MediaQuery.of(context).size.width / controller.gridCount - borderWidth;
  return GestureDetector(
    onTap: () {
      bool isEmptyBox = controller.boxClickAction(x, y);
      if (!isEmptyBox) {
        errorSnackBar(
          title: '안돼요!!',
          message: '이미 놓은 자리에요!!',
        );
      }
    },
    child: Center(
      child: Container(
        width: width > 200 ? 200 : width,
        height: width > 200 ? 200 : width,
        color: Colors.white70,
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon,
                  size: constraints.maxWidth * 0.8, // container의 사이즈에 맞게 동적 조절
                  color: (icon == Icons.abc)
                      ? Colors.transparent
                      : (icon == controller.playerOneMarker)
                          ? controller.playerOneColor
                          : controller.playerTwoColor),
              Positioned(
                top: 5,
                right: 5,
                child: Text(
                  controller.recordData['($x,$y)'] == 0
                      ? ''
                      // : controller.recordData['($x,$y)'].toString()),
                      : '',
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
