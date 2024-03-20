import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    // db 안에 table이 없을 때만 실행됨
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tictactoe.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE records (id INTEGER PRIMARY KEY AUTOINCREMENT, boardSize INTEGER, recordData TEXT, playerOneIcon INTEGER, playerTwoIcon INTEGER, playerOneColor INTEGER, playerTwoColor INTEGER, isPlayerOneStartFirst INTEGER, align INTEGER, playerOneRemainBackies INTEGER, playerTwoRemainBackies INTEGER, dateTime TEXT, result TEXT)");
      },
      version: 1,
    );
  }

//
  Future<List<RecordModel>> queryAllRecord() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults =
        await db.rawQuery('SELECT * FROM records ORDER BY dateTime DESC');

    return queryResults.map((e) => RecordModel.fromJson(e)).toList();
  }

//
  Future<void> insertRecord(RecordModel record) async {
    final Database db = await initializeDB();
    await db.rawInsert(
      'INSERT INTO records(boardSize, recordData, playerOneIcon, playerTwoIcon, playerOneColor, playerTwoColor, isPlayerOneStartFirst, align, playerOneRemainBackies, playerTwoRemainBackies, dateTime, result) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        record.boardSize,
        record.recordData.toString(), // recordData를 문자열로 변환하여 삽입
        record.playerOneIconCode,
        record.playerTwoIconCode,
        record.playerOneColorIndex,
        record.playerTwoColorIndex,
        record.isPlayerOneStartFirst,
        record.align,
        record.playerOneRemainBackies,
        record.playerTwoRemainBackies,
        record.dateTime,
        record.result,
      ],
    );
  }

  Future<void> deleteRecord(int id) async {
    final Database db = await initializeDB();
    await db.rawDelete(
      'delete from records where id = ?', 
      [id], // []안의 값이 ?값
    );
  }

  Future<void> deleteAllRecord() async {
    final Database db = await initializeDB();
    await db.rawDelete(
      'delete from records',
    );
  }
} // End