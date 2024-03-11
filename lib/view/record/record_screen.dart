import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe_app/%08common/button.dart';
import 'package:tic_tac_toe_app/%08common/font_style.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';

class RecordScreen extends StatelessWidget {
  final RecordModel recordModel;
  const RecordScreen({super.key, required this.recordModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('게임 기록'),
        actions: [
          HomeButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '승리조건 : ${recordModel.align}칸 완성',
              style: AppStyle.smallTextStyle,
            ),
            Row(
              children: [
                playerResultInfo(playerOne: true),
                playerResultInfo(playerOne: false),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(recordModel.result, style: AppStyle.normalTextStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: resultGameBoard(
                context,
                boardSize: recordModel.boardSize,
                recordModel: recordModel,
                isSmall: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget playerResultInfo({
    required bool playerOne,
  }) {
    return Container(
      width: 170.w,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Player ${playerOne ? 1 : 2}',
              style: AppStyle.settingTitleStyle,
            ),
          ),
          Text(
              '남은 무르기 : ${playerOne ? recordModel.playerOneRemainBackies : recordModel.playerTwoRemainBackies}회',
              style: AppStyle.smallTextStyle,
          ),
          Icon(
            playerOne
                ? recordModel.getPlayerOneIcon()
                : recordModel.getPlayerTwoIcon(),
            color: playerOne
                ? recordModel.getPlayerOneColor()
                : recordModel.getPlayerTwoColor(),
            size: 70,
          ),
        ],
      ),
    );
  }
}

Widget resultGameBoard(context,
    {required int boardSize,
    required RecordModel recordModel,
    required bool isSmall}) {
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
  return SizedBox(
    width: 393.w,
    child: GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridCount),
      children: boxList,
    ),
  );
}

Widget resultBoardBox(
    context, int x, int y, int boardSize, Map<String, int> recordData,
    {IconData? icon, Color? color, required bool isSmall}) {
  return Center(
    child: Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            border: isSmall
                ? Border.all(color: Colors.black, width: 1)
                : Border.all(color: Colors.blueGrey, width: 3)),
        width: 393.w / boardSize,
        height: 393.w / boardSize,
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon,
                  size: constraints.maxWidth * 0.8, // container의 사이즈에 맞게 동적 조절
                  color: color),
              Positioned(
                top: 2,
                right: 2,
                child: Text(recordData['($x,$y)'] == 0 || isSmall
                    ? ''
                    : recordData['($x,$y)'].toString()),
              ),
              // : '')),
            ],
          ),
        ),
      ),
    ),
  );
}
