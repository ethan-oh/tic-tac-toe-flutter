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
      body: FutureBuilder(
          future: controller.handler.queryGames(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child:
                        Text('저장된 기록이 없습니다.', style: AppStyle.alertTextStyle),
                  ),
                ],
              );
            } else {
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.to(() =>
                          RecordScreen(recordModel: snapshot.data![index])),
                      child: Card(
                        child: Column(
                          children: [
                            Text(snapshot.data![index].dateTime),
                            Text(
                                '게임판 : ${controller.getBoardSize(snapshot.data![index].boardSize)}'),
                            Text('승리 조건 : ${snapshot.data![index].align}칸 완성'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
