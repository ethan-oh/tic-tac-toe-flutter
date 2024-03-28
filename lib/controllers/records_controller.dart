import 'dart:async';

import 'package:get/get.dart';
import 'package:tic_tac_toe_app/models/database_handler.dart';
import 'package:tic_tac_toe_app/models/record_model.dart';

class RecordsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    queryAllRecord();
  }

  List<RecordModel> _records = [];
  List<RecordModel> get records => _records;

  Future<void> queryAllRecord() async {
    _records = await DatabaseHandler.queryAllRecord();
    update();
  }

  String convertBoardCountToString(int boardSize) {
    return boardSize == 3
        ? '3X3'
        : boardSize == 4
            ? '4X4'
            : '5X5';
  }

  Future<void> deleteRecord(int id) async {
    await DatabaseHandler.deleteRecord(id);
    queryAllRecord();
  }

  Future<void> deleteAllRecord() async {
    await DatabaseHandler.deleteAllRecord();
    queryAllRecord();
  }
}
