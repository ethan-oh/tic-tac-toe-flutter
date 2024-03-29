import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';

class ResultBoard extends StatelessWidget {
  final BuildContext context;
  final int boardSize;
  final RecordModel recordModel;
  final bool isSmall;

  const ResultBoard(
    this.context, {
    super.key,
    required this.boardSize,
    required this.recordModel,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    int gridCount = boardSize;
    bool isPlayerOneStartFirst =
        recordModel.isPlayerOneStartFirst == 1 ? true : false;
    Map<String, int> recordData = recordModel.convertRecordDataToMap();
    List<Widget> boxList = [];
    for (int i = 1; i <= boardSize; i++) {
      for (int j = 1; j <= boardSize; j++) {
        IconData icon;
        Color color;
        if (isPlayerOneStartFirst) {
          // 홀수가 player1
          icon = recordData['($i,$j)']! == 0
              ? Icons.abc
              : (recordData['($i,$j)']! % 2 == 0)
                  ? recordModel.getPlayerTwoIcon()
                  : recordModel.getPlayerOneIcon();
          color = recordData['($i,$j)']! == 0
              ? Colors.transparent
              : (recordData['($i,$j)']! % 2 == 0)
                  ? recordModel.getPlayerTwoColor()
                  : recordModel.getPlayerOneColor();
        } else {
          // 홀수가 player2
          icon = recordData['($i,$j)']! == 0
              ? Icons.abc
              : (recordData['($i,$j)']! % 2 == 0)
                  ? recordModel.getPlayerOneIcon()
                  : recordModel.getPlayerTwoIcon();
          color = recordData['($i,$j)']! == 0
              ? Colors.transparent
              : (recordData['($i,$j)']! % 2 == 0)
                  ? recordModel.getPlayerOneColor()
                  : recordModel.getPlayerTwoColor();
        }

        boxList.add(
          resultBoardBox(context, i, j, gridCount, recordData,
              icon: icon, color: color, isSmall: isSmall),
        );
      }
    }
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount),
      children: boxList,
    );
  }
}

Widget resultBoardBox(
    context, int x, int y, int boardSize, Map<String, int> recordData,
    {IconData? icon, Color? color, required bool isSmall}) {
  double boardWidth = Get.width;
  return Container(
    color: Colors.white,
    width: boardWidth / boardSize,
    height: boardWidth / boardSize,
    child: Container(
      decoration: BoxDecoration(
          border: isSmall
              ? Border.all(color: Colors.black, width: 1)
              : Border.all(color: Colors.blueGrey, width: 3)),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              size: constraints.maxWidth * 0.8, // container의 사이즈에 맞게 동적 조절
              color: color,
            ),
            isSmall
                ? Container()
                : Positioned(
                    top: 2,
                    right: 2,
                    child: Material(
                      // Hero에 사용할 수 없는 Text 위젯을 사용하기 위해 Material 속성을 부여
                      type: MaterialType.transparency,
                      child: Text(
                        recordData['($x,$y)'] == 0
                            ? ''
                            : recordData['($x,$y)'].toString(),
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}
