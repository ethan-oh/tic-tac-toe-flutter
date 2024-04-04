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

  final RxList<RecordModel> _records = <RecordModel>[].obs;
  List<RecordModel> get records => _records;

  Future<void> fethcAllRecords() async {
    _records.value = await DBHelper.fetchAllRecords();
    // update();
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
