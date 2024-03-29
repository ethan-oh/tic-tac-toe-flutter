import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';

class ResultPlayerInfo extends StatelessWidget {
  const ResultPlayerInfo({
    super.key,
    required this.recordModel,
    required this.playerOne,
  });

  final RecordModel recordModel;
  final bool playerOne;

  @override
  Widget build(BuildContext context) {
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
              style: settingTitleStyle,
            ),
          ),
          Text(
            '남은 무르기 : ${playerOne ? recordModel.playerOneRemainBackies : recordModel.playerTwoRemainBackies}회',
            style: smallTextStyle,
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