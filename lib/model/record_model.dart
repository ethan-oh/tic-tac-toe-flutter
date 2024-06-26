import 'package:flutter/material.dart';
import 'dart:convert';

class RecordModel {
  final int? id;
  final int boardSize; // 게임판 크기
  final int playerOneIconCode;
  final int playerTwoIconCode;
  final int playerOneColorIndex;
  final int playerTwoColorIndex;
  final int playerOneRemainBackies; // 남은 무르기 횟수
  final int playerTwoRemainBackies;
  final int isPlayerOneStartFirst; // 선공
  final int align;
  final String recordData; // 좌표별 순서 기억
  final String dateTime;
  final String result;

  RecordModel({
    this.id,
    required this.boardSize,
    required this.recordData,
    required this.playerOneIconCode,
    required this.playerTwoIconCode,
    required this.playerOneColorIndex,
    required this.playerTwoColorIndex,
    required this.isPlayerOneStartFirst,
    required this.align,
    required this.playerOneRemainBackies,
    required this.playerTwoRemainBackies,
    required this.dateTime,
    required this.result,
  });

  // db에서 Json 데이터 받아와 RecordModel로 변환
  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['id'],
      boardSize: json['boardSize'],
      recordData: json['recordData'],
      playerOneIconCode: json['playerOneIcon'],
      playerTwoIconCode: json['playerTwoIcon'],
      playerOneColorIndex: json['playerOneColor'],
      playerTwoColorIndex: json['playerTwoColor'],
      isPlayerOneStartFirst: json['isPlayerOneStartFirst'],
      align: json['align'],
      playerOneRemainBackies: json['playerOneRemainBackies'],
      playerTwoRemainBackies: json['playerTwoRemainBackies'],
      dateTime: _formatStringDateTime(json['dateTime']),
      result: json['result'],
    );
  }

  // static 놓은 이유: factory 생성자에서 사용하려면 미리 만들어진 함수여야함.
  // 날짜순으로 정렬하기 위해 db에는 원본으로 저장, 담아줄 때는 변환해서 저장하기 위한 함수
    static String _formatStringDateTime(String stringDateTime) {
    DateTime dateTime = DateTime.parse(stringDateTime);
    dateTime = dateTime.toUtc().add(const Duration(hours: 9));
    String year = dateTime.year.toString().padLeft(4, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$year.$month.$day  $hour:$minute';
  }

  IconData get playerOneIcon {
    switch (playerOneIconCode) {
      case 1:
        return Icons.circle_outlined;
      case 2:
        return Icons.close;
      case 3:
        return Icons.change_history;
      case 4:
        return Icons.square_outlined;
      default:
        throw Exception('Invalid player one icon code');
    }
  }

  IconData get playerTwoIcon {
    switch (playerTwoIconCode) {
      case 1:
        return Icons.circle_outlined;
      case 2:
        return Icons.close;
      case 3:
        return Icons.change_history;
      case 4:
        return Icons.square_outlined;
      default:
        throw Exception('Invalid player two icon code');
    }
  }

  Color get playerOneColor {
    switch (playerOneColorIndex) {
      case 1:
        return Colors.indigo;
      case 2:
        return const Color(0xFFD32F2F);
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      default:
        throw Exception('Invalid player one color index');
    }
  }

  Color get playerTwoColor {
    switch (playerTwoColorIndex) {
      case 1:
        return Colors.indigo;
      case 2:
        return const Color(0xFFD32F2F);
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      default:
        throw Exception('Invalid player two color index');
    }
  }

  Map<String, int> convertRecordDataToMap() {
    Map<String, dynamic> dynamicMap = json.decode(recordData);
    // 변환된 맵을 초기화합니다.
    Map<String, int> resultMap = {};

    // 각 키-값 쌍을 반복하여 맵에 추가합니다.
    dynamicMap.forEach(
      (key, value) {
        resultMap[key] = value as int;
      },
    );

    return resultMap;
  }

  // 모델 저장 시 IconData값을 받아와 int값인 코드로 변환. DB 저장 위해
  static int convertIconToCode(IconData iconData) {
    switch (iconData) {
      case Icons.circle_outlined:
        return 1;
      case Icons.close:
        return 2;
      case Icons.change_history:
        return 3;
      case Icons.square_outlined:
        return 4;
      default:
        throw Exception('Invalid player one icon code');
    }
  }

  static int convertColorToCode(Color color) {
    switch (color) {
      case Colors.indigo:
        return 1;
      case const Color(0xFFD32F2F):
        return 2;
      case Colors.green:
        return 3;
      case Colors.orange:
        return 4;
      default:
        throw Exception('Invalid player one icon code');
    }
  }
}
