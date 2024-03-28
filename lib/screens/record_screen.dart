import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/constants.dart';
import 'package:tic_tac_toe_app/widgets/records/result_board.dart';
import 'package:tic_tac_toe_app/widgets/home_button.dart';
import 'package:tic_tac_toe_app/models/record_model.dart';
import 'package:tic_tac_toe_app/widgets/records/result_player_info.dart';

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
          _winConditionText(),
          _resultInfo(),
          _winner(),
          _board(context),
        ],
      ),
    );
  }

  Row _resultInfo() {
    return Row(
      children: [
        ResultPlayerInfo(recordModel: recordModel, playerOne: true),
        ResultPlayerInfo(recordModel: recordModel, playerOne: false),
      ],
    );
  }

  Text _winConditionText() {
    return Text(
      '승리조건 : ${recordModel.align}칸 완성',
      style: smallTextStyle,
    );
  }

  Padding _winner() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        type: MaterialType.transparency,
        child: Text(recordModel.result, style: normalTextStyle),
      ),
    );
  }

  Hero _board(BuildContext context) {
    return Hero(
      tag: 'board_${recordModel.id!}',
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: ResultBoard(
          context,
          boardSize: recordModel.boardSize,
          recordModel: recordModel,
          isSmall: false,
        ),
      ),
    );
  }
}

