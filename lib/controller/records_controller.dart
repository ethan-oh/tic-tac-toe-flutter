import 'dart:async';

import 'package:get/get.dart';
import 'package:tic_tac_toe_app/model/database_handler.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';

class RecordsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    handler = DatabaseHandler();
    queryAllRecords();
  }

  late DatabaseHandler handler;
  List<RecordModel> records = [];

  Future<void> queryAllRecords() async {
    records = await handler.queryAllRecord();
    update();
  }

  String getBoardSize(int boardSize) {
    return boardSize == 3
        ? '3X3'
        : boardSize == 4
            ? '4X4'
            : '5X5';
  }

  Future<void> deleteRecord(int id) async {
    await handler.deleteRecord(id);
    queryAllRecords();
  }
}
