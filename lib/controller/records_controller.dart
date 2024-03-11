import 'package:get/get.dart';
import 'package:tic_tac_toe_app/model/database_handler.dart';

class RecordsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    handler = DatabaseHandler();
  }

  late DatabaseHandler handler;

  String getBoardSize(int boardSize) {
    return boardSize == 3
        ? '3X3'
        : boardSize == 4
            ? '4X4'
            : '5X5';
  }

  Future<void> deleteRecord(int id) async{
    await handler.deleteGames(id);
  }
}
