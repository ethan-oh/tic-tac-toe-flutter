import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe_app/common/font_style.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';
import 'package:tic_tac_toe_app/view/record/result_board.dart';

class RecordCard extends StatelessWidget {
  final BuildContext context;
  final RecordModel recordModel;
  const RecordCard(this.context, {super.key, required this.recordModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            width: 100.w,
            height: 100.w,
            child: Hero(
              tag: 'board_${recordModel.id!}',
              child: ResultBoard(
                context,
                boardSize: recordModel.boardSize,
                recordModel: recordModel,
                isSmall: true,
              ),
            ),
          ),
          SizedBox(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'winner_${recordModel.id!}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      recordModel.result,
                      style: AppStyle.normalTextStyle,
                    ),
                  ),
                ),
                Text(
                  '조건 : ${recordModel.align.toString()}칸 완성',
                  style: AppStyle.dateTimeTextStyle,
                ),
                Text(
                  recordModel.dateTime,
                  style: AppStyle.dateTimeTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
