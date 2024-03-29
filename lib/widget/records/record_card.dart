import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';
import 'package:tic_tac_toe_app/widget/records/result_board.dart';

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
                Material(
                  type: MaterialType.transparency,
                  child: Text(
                    recordModel.result,
                    style: normalTextStyle,
                  ),
                ),
                Text(
                  '조건 : ${recordModel.align.toString()}칸 완성',
                  style: dateTimeTextStyle,
                ),
                Text(
                  recordModel.dateTime,
                  style: dateTimeTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
