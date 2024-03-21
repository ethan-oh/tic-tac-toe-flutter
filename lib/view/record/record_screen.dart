import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe_app/view/record/result_board.dart';
import 'package:tic_tac_toe_app/common/home_button.dart';
import 'package:tic_tac_toe_app/common/font_style.dart';
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
        actions: const [
          HomeButton(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '승리조건 : ${recordModel.align}칸 완성',
            style: AppStyle.smallTextStyle,
          ),
          Row(
            children: [
              _playerResultInfo(playerOne: true),
              _playerResultInfo(playerOne: false),
            ],
          ),
          _winner(),
          Hero(
            tag: 'board_${recordModel.id!}',
            child: _board(context),
          ),
        ],
      ),
    );
  }

  Padding _winner() {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            type: MaterialType.transparency,
            child:
                Text(recordModel.result, style: AppStyle.normalTextStyle),
          ),
        );
  }

  Padding _board(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: ResultBoard(
        context,
        boardSize: recordModel.boardSize,
        recordModel: recordModel,
        isSmall: false,
      ),
    );
  }

  Widget _playerResultInfo({required bool playerOne}) {
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
