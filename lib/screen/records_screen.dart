import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/util/alert_dialog.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';
import 'package:tic_tac_toe_app/controller/records_controller.dart';
import 'package:tic_tac_toe_app/widget/records/record_card.dart';
import 'package:tic_tac_toe_app/screen/record_screen.dart';

class RecordsScreen extends GetView<RecordsController> {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기록 보기'),
        actions: [
          _deleteAllButton(),
        ],
      ),
      body: Center(
        child: Obx(
          () => controller.records.isEmpty
              ? _emptyList()
              : _recordList(controller),
        ),
      ),
    );
  }

  Widget _deleteAllButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        onPressed: () => controller.records.isNotEmpty
            ? showAlertDialog(
                title: '삭제',
                middleText: '기록을 모두 삭제하시겠습니까?',
                onConfirm: () async {
                  controller.deleteAllRecords();
                  Get.back();
                },
              )
            : null, // 기록이 없을 때는 아무 동작하지 않음.
        icon: Icon(
          Icons.delete,
          size: 35,
          color: Colors.red[900],
        ),
      ),
    );
  }

  Widget _emptyList() {
    return const Center(
      child: Text(
        '저장된 게임이 없습니다.',
        style: normalTextStyle,
      ),
    );
  }

  ListView _recordList(RecordsController controller) {
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
                  controller.deleteRecordById(id);
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
