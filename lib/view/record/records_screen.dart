import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/%08common/font_style.dart';
import 'package:tic_tac_toe_app/controller/records_controller.dart';
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
              ? const Center(
                  child: Text(
                  '저장된 게임이 없습니다.',
                  style: AppStyle.normalTextStyle,
                ))
              : ListView.builder(
                  itemCount: controller.records.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
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
                      child: GestureDetector(
                        onTap: () => Get.to(() => RecordScreen(
                            recordModel: controller.records[index])),
                        child: SizedBox(
                          width: 393.w,
                          child: Card(
                            child: Column(
                              children: [
                                Text(controller.records[index].dateTime),
                                Text(
                                    '게임판 : ${controller.getBoardSize(controller.records[index].boardSize)}'),
                                Text(
                                    '승리 조건 : ${controller.records[index].align}칸 완성'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
