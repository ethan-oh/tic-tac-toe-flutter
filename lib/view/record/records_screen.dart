import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/font_style.dart';
import 'package:tic_tac_toe_app/controller/records_controller.dart';
import 'package:tic_tac_toe_app/view/record/record_card.dart';
import 'package:tic_tac_toe_app/view/record/record_screen.dart';

class RecordsScreen extends GetView<RecordsController> {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('기록 보기'),
        backgroundColor: Colors.blueGrey,
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
            transition: Transition.noTransition,
            duration: const Duration(seconds: 1),
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
            child: RecordCard(
              context,
              recordModel: controller.records[index],
            ),
          ),
        );
      },
    );
  }
}
