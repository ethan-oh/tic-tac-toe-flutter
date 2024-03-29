import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/util/error_snackbar.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';

Widget boardBox(context, int x, int y, {IconData? icon}) {
  GameController controller = Get.find<GameController>();

  double boardWidth = (kIsWeb) ? (Get.height - 173) * 0.8 : Get.width;
  return GestureDetector(
    onTap: () {
      if (!controller.isGameFinish()) {
        bool isEmptyBox = controller.boxClickAction(x, y);
        if (!isEmptyBox) {
          showErrorSnackBar(
            title: '안돼요!!',
            message: '이미 놓은 자리에요!!',
          );
        }
      }
    },
    child: Container(
      color: Colors.white70,
      width: boardWidth / controller.gridCount,
      height: boardWidth / controller.gridCount,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 3,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                size: constraints.maxWidth * 0.8, // container의 사이즈에 맞게 동적 조절
                color: (icon == Icons.abc)
                    ? Colors.transparent
                    : (icon == controller.playerOneMarker)
                        ? controller.playerOneColor
                        : controller.playerTwoColor,
              ),
              Visibility(
                visible: controller.isGameFinish(),
                child: Positioned(
                  top: 2,
                  right: 2,
                  child: Material(
                    // Hero에 사용할 수 없는 Text 위젯을 사용하기 위해 Material 속성을 부여
                    type: MaterialType.transparency,
                    child: Text(
                      controller.recordData['($x,$y)'] == 0
                          ? ''
                          : controller.recordData['($x,$y)'].toString(),
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
