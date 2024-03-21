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
      // backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('기록 보기'),
        // backgroundColor: Colors.blueGrey,
        actions: [
          _deleteAllButton(),
        ],
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
  // scafold

  Padding _deleteAllButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        onPressed: () => Get.defaultDialog(
            title: "삭제",
            middleText: "기록을 모두 삭제하시겠습니까?",
            buttonColor: Colors.blue,
            backgroundColor: Colors.white,
            confirmTextColor: Colors.white,
            textConfirm: "확인",
            onConfirm: () =>
                controller.deleteAllRecord().then((value) => Get.back()),
            textCancel: "취소",
            onCancel: () {}),
        icon: Icon(
          Icons.delete,
          size: 35,
          color: Colors.red[900],
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
        return Slidable(
          closeOnScroll: true,
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.red[900]!,
                icon: Icons.delete,
                label: '삭제',
                onPressed: (context) {
                  int id = controller.records[index].id!;
                  controller.deleteRecord(id);
                },
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () => Get.to(
              () => RecordScreen(
                recordModel: controller.records[index],
              ),
              fullscreenDialog: true,
              duration: const Duration(seconds: 1),
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
