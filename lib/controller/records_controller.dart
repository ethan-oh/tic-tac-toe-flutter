import 'dart:async';

import 'package:get/get.dart';
import 'package:tic_tac_toe_app/model/db_helper.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';

class RecordsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fethcAllRecords();
  }

  List<RecordModel> _records = [];
  List<RecordModel> get records => _records;

  Future<void> fethcAllRecords() async {
    _records = await DBHelper.fetchAllRecords();
    update();
  }

  String convertBoardCountToString(int boardSize) {
    return boardSize == 3
        ? '3X3'
        : boardSize == 4
            ? '4X4'
            : '5X5';
  }

  Future<void> deleteRecordById(int id) async {
    await DBHelper.deleteRecordById(id);
    fethcAllRecords();
  }

  Future<void> deleteAllRecords() async {
    await DBHelper.deleteAllRecords();
    fethcAllRecords();
  }
}
