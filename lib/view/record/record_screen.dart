import 'package:flutter/material.dart';
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
              style: AppStyle.normalTextStyle,
            ),
            Row(
              children: [
                playerResultInfo(playerOne: true),
                playerResultInfo(playerOne: false),
              ],
            ),
            resultGameBoard(context, recordModel.boardSize),
          ],
        ),
      ),
    );
  }

  Widget resultGameBoard(context, int boardSize) {
    int gridCount = boardSize;
    double width = MediaQuery.of(context).size.width;
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
              icon: icon, color: color),
        );
      }
    }
    return SizedBox(
      width: width > 600 ? (600 + boardSize.toDouble() * 10) : width,
      child: GridView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount),
        children: boxList,
      ),
    );
  }

  Widget resultBoardBox(
      context, int x, int y, boardSize, Map<String, int> recordData,
      {IconData? icon, Color? color}) {
    double borderWidth = 10;
    double width = MediaQuery.of(context).size.width / boardSize - borderWidth;
    return Center(
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
                  color: color),
              Positioned(
                top: 5,
                right: 5,
                child: Text(recordData['($x,$y)'] == 0
                    ? ''
                    : recordData['($x,$y)'].toString()),
              ),
              // : '')),
            ],
          ),
        ),
      ),
    );
  }

  Widget playerResultInfo({required bool playerOne}) {
    return Container(
      width: 170,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Player ${playerOne ? 1 : 2}',
            style: AppStyle.settingTitleStyle,
          ),
          const Text('무르기'),
          Text(
              '남은 횟수 : ${playerOne ? recordModel.playerOneRemainBackies : recordModel.playerTwoRemainBackies}개'),
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
