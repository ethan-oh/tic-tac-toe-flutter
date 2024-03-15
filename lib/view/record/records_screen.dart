import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/font_style.dart';
import 'package:tic_tac_toe_app/controller/records_controller.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';
import 'package:tic_tac_toe_app/view/record/record_screen.dart';

class RecordsScreen extends GetView<RecordsController> {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기록 보기'),
      ),
      body: Center(
        child: GetBuilder<RecordsController>(
          builder: (controller) => controller.records.isEmpty
              ? emptyRecord()
              : makeRecordList(controller),
        ),
      ),
    );
  }

  Center emptyRecord() {
    return const Center(
      child: Text(
        '저장된 게임이 없습니다.',
        style: AppStyle.normalTextStyle,
      ),
    );
  }

  ListView makeRecordList(RecordsController controller) {
    return ListView.builder(
      itemCount: controller.records.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Get.to(
            () => RecordScreen(
              recordModel: controller.records[index],
            ),
            fullscreenDialog: true,
            duration: const Duration(milliseconds: 800),
          ),
          child: Slidable(
            key: ValueKey(index), // onDismissed를 위해
            closeOnScroll: true,
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              dismissible: DismissiblePane(
                // 끝까지 당기면 바로 액션함
                onDismissed: () async {
                  int id = controller.records[index].id!;
                  await controller.deleteRecord(id);
                },
              ),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: '삭제',
                  onPressed: (context) async {
                    int id = controller.records[index].id!;
                    await controller.deleteRecord(id);
                  },
                ),
              ],
            ),
            child: recordCard(
              context,
              controller.records[index],
            ),
          ),
        );
      },
    );
  }
}

Widget recordCard(context, RecordModel record) {
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
          child: resultGameBoard(
            context,
            boardSize: record.boardSize,
            recordModel: record,
            isSmall: true,
          ),
        ),
        SizedBox(
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record.result,
                style: AppStyle.normalTextStyle,
              ),
              Text(
                '조건 : ${record.align.toString()}칸 완성',
                style: AppStyle.dateTimeTextStyle,
              ),
              Text(
                record.dateTime,
                style: AppStyle.dateTimeTextStyle,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
