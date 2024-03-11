import 'package:flutter/material.dart';
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
          builder: (controller) => ListView.builder(
            itemCount: controller.records.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.to(
                    () => RecordScreen(recordModel: controller.records[index])),
                child: Card(
                  child: Column(
                    children: [
                      Text(controller.records[index].dateTime),
                      Text(
                          '게임판 : ${controller.getBoardSize(controller.records[index].boardSize)}'),
                      Text('승리 조건 : ${controller.records[index].align}칸 완성'),
                    ],
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
