import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/enums.dart';
import 'package:tic_tac_toe_app/model/database_handler.dart';
import 'package:tic_tac_toe_app/model/record_model.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';

enum GameStatus { playing, playerOneWin, playerTwoWin, draw }

class GameController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    gameInit();
  }

  // binding 받아온 game setting 값
  final SettingModel settings;
  // 생성자 통해 setting값 받아오기
  GameController(this.settings);

  // setting model을 통해 받아온 설정값을 변수에 저장
  late final IconData playerOneMarker = settings.playerOneMarker;
  late final IconData playerTwoMarker = settings.playerTwoMarker;
  late final Color playerOneColor = settings.playerOneColor;
  late final Color playerTwoColor = settings.playerTwoColor;
  late final int gridCount = settings.gridCount;
  late final int alignCount = settings.alignCount;
  // 2차원 Icon 리스트
  late List<List<IconData>> iconList;
  // 게임 턴 확인
  late bool isPlayerOneTurn;
  // 무르기버튼 비활성화 여부
  late bool isPlayerOneBacksiesButtonDisable;
  late bool isPlayerTwoBacksiesButtonDisable;

  /// 현재 차례에 무르기 사용 여부 판단 (무르기 사용 후 그 전 턴까지 무르지 못하게 하기 위해)
  late bool isAlreadyUseBacksies;
  // 무르기 회수
  late int playerOneBackCount;
  late int playerTwoBackCount;
  // player1 마지막 놓은 좌표 저장 위한 변수
  late int lastPlayerOneX;
  late int lastPlayerOneY;
  // player2 좌표 저장 변수
  late int lastPlayerTwoX;
  late int lastPlayerTwoY;
  // 현재 게임 상태
  late GameStatus gameStatus;
  late String resultMessage;
  // 기록 저장을 위한 좌표값 배열
  late Map<String, int> recordData;
  // 놓은 순서 저장 위한 변수
  late int index;
  late bool isPlayerOneStartFirst;
  late String result;

  /////////////////////////// 게임 세팅 /////////////////////////////////
  void gameInit() {
    isPlayerOneBacksiesButtonDisable = true;
    isPlayerTwoBacksiesButtonDisable = true;
    isAlreadyUseBacksies = false;
    playerOneBackCount = 3;
    playerTwoBackCount = 3;
    lastPlayerOneX = 0;
    lastPlayerOneY = 0;
    lastPlayerTwoX = 0;
    lastPlayerTwoY = 0;
    playerOneBackCount = 3;
    playerTwoBackCount = 3;
    isPlayerOneTurn = setFirstPlayer();
    isPlayerOneStartFirst = isPlayerOneTurn; // 선공이 정해지면 저장 => 기록 위해서
    gameStatus = GameStatus.playing;
    index = 0;
    result = '';
    _iconListInit();
    recordDataInit();
  }

  void recordDataInit() {
    recordData = {};
    for (int i = 1; i <= gridCount; i++) {
      for (int j = 1; j <= gridCount; j++) {
        recordData['($i,$j)'] = 0;
      }
    }
  }

  void _iconListInit() {
    iconList = List.generate(
        gridCount, (index) => List.generate(gridCount, ((index) => Icons.abc)));
  }

  bool setFirstPlayer() {
    return settings.firstPlayer == TurnOpt.playerOne
        ? true
        : settings.firstPlayer == TurnOpt.playerTwo
            ? false
            : Random().nextInt(2) == 1
                ? true
                : false;
  }

  // 무르기 기능을 위한 마지막 놓은 좌표 저장
  void _saveLastPoint(int x, int y) {
    if (isPlayerOneTurn) {
      lastPlayerOneX = x;
      lastPlayerOneY = y;
    } else {
      lastPlayerTwoX = x;
      lastPlayerTwoY = y;
    }
  }

  void restart() {
    gameInit();
    update();
  }

//////////////////////////////// 게임 플레이 //////////////////////////////////////////
  bool boxClickAction(int x, int y) {
    bool isEmpty = true;
    // 마커 놓은 후 무르기 버튼 비활성화 여부 체크
    gameStatus = GameStatus.playing;

    if (iconList[x - 1][y - 1] == Icons.abc) {
      // 비어있다면
      // 마커 놓기
      iconList[x - 1][y - 1] =
          (isPlayerOneTurn) ? playerOneMarker : playerTwoMarker;
      index += 1;
      recordData['($x,$y)'] = index;
      // 마지막 값 저장
      _saveLastPoint(x, y);
      // * 저장 후에 순서 변경
      isPlayerOneTurn = !isPlayerOneTurn;
      isAlreadyUseBacksies = false;
      _backsiesButtonDisableCheck();
      _gameCheck();
    } else {
      isEmpty = false;
    }
    update();
    return isEmpty;
  }

  void _backsiesButtonDisableCheck() {
    _playerOneBacksiesButtonDisableCheck();
    _playerTwoBacksiesButtonDisableCheck();
  }

  void _playerOneBacksiesButtonDisableCheck() {
    if (isPlayerOneTurn) {
      isPlayerOneBacksiesButtonDisable = true;
      return;
    } else if (playerOneBackCount <= 0) {
      isPlayerOneBacksiesButtonDisable = true;
      return;
    } else if (isAlreadyUseBacksies) {
      isPlayerOneBacksiesButtonDisable = true;
    } else {
      isPlayerOneBacksiesButtonDisable = false;
    }
  }

  void _playerTwoBacksiesButtonDisableCheck() {
    if (!isPlayerOneTurn) {
      isPlayerTwoBacksiesButtonDisable = true;
      return;
    } else if (playerTwoBackCount <= 0) {
      isPlayerTwoBacksiesButtonDisable = true;
      return;
    } else if (isAlreadyUseBacksies) {
      isPlayerTwoBacksiesButtonDisable = true;
    } else {
      isPlayerTwoBacksiesButtonDisable = false;
    }
  }

  /// 무르기 버튼 액션 (활성화 되어있을때 기준)
  void playerOneBacksiesButtonAction() {
    isAlreadyUseBacksies = true;
    playerOneBackCount -= 1;
    iconList[lastPlayerOneX - 1][lastPlayerOneY - 1] = Icons.abc;
    isPlayerOneTurn = !isPlayerOneTurn;
    index -= 1;
    recordData['($lastPlayerOneX,$lastPlayerOneY)'] = 0;
    _backsiesButtonDisableCheck();
    update();
  }

  void playerTwoBacksiesButtonAction() {
    isAlreadyUseBacksies = true;
    playerTwoBackCount -= 1;
    iconList[lastPlayerTwoX - 1][lastPlayerTwoY - 1] = Icons.abc;
    isPlayerOneTurn = !isPlayerOneTurn;
    index -= 1;
    recordData['($lastPlayerTwoX,$lastPlayerTwoY)'] = 0;
    _backsiesButtonDisableCheck();
    update();
  }

  ////////////////////////// 승리 체크 ////////////////////////////////
  void _gameCheck() {
    // 승리 체크
    if (_isConsecutive(iconList, playerOneMarker, alignCount)) {
      gameStatus = GameStatus.playerOneWin;
      resultMessage = 'Player 1 Win';
      result = 'Player 1 승리';
    } else if (_isConsecutive(iconList, playerTwoMarker, alignCount)) {
      gameStatus = GameStatus.playerTwoWin;
      resultMessage = 'Player 2 Win';
      result = 'Player 2 승리';
    }
    // 무승부 체크
    if (!_isAnyEmptyBox(iconList) &&
        gameStatus != GameStatus.playerOneWin &&
        gameStatus != GameStatus.playerTwoWin) {
      gameStatus = GameStatus.draw;
      resultMessage = '무승부';
      result = '무승부';
    }
  }

  // grid와 승리 조건에 맞게 승리 탐색. 승리하면 true를 리턴함.
  // 인자는 이차원배열과 누구의 아이콘인지, n은 승리 조건.
  bool _isConsecutive(List<List<IconData>> board, IconData icon, int n) {
    for (int i = 0; i < board.length; i++) {
      // i: 가로줄
      // 가로줄 검사
      for (int j = 0; j < board[i].length - n + 1; j++) {
        // j: 몇 번 검사할지(4by4에서 승리조건이 3일 때: 123, 234 총 두 번 탐색)
        bool isConsecutive = true;
        for (int k = 0; k < n; k++) {
          // k : 세로 인덱스
          if (board[i][j + k] != icon) {
            isConsecutive = false;
            break;
          }
        }
        if (isConsecutive) {
          return true;
        }
      }
      // 세로줄 검사
      for (int j = 0; j < board[i].length - n + 1; j++) {
        bool isConsecutive = true;
        for (int k = 0; k < n; k++) {
          if (board[j + k][i] != icon) {
            isConsecutive = false;
            break;
          }
        }
        if (isConsecutive) {
          return true;
        }
      }
    }
    // 대각선 검사
    // 정방향 대각선 검사
    for (int i = 0; i < board.length - n + 1; i++) {
      // 대각선 개수와 승리조건이 같으면 1번만
      bool isConsecutive = true;
      for (int j = 0; j < n; j++) {
        if (board[i + j][i + j] != icon) {
          // 위에서부터 검사하다 다른 아이콘 만나면 false 리턴
          isConsecutive = false;
          break;
        }
      }
      if (isConsecutive) {
        return true;
      }
    }
    // 역방향 대각선 검사
    for (int i = 0; i < board.length - n + 1; i++) {
      bool isConsecutive = true;
      for (int j = 0; j < n; j++) {
        if (board[i + j][board.length - 1 - i - j] != icon) {
          isConsecutive = false;
          break;
        }
      }
      if (isConsecutive) {
        return true;
      }
    }

    // 특이 케이스
    if (board.length == 4 && n == 3) {
      // 4by4 && 승리조건 3 특이 케이스
      if ((board[0][1] == icon && board[1][2] == icon && board[2][3] == icon) ||
          (board[1][0] == icon && board[2][1] == icon && board[3][2] == icon) ||
          (board[0][2] == icon && board[1][1] == icon && board[2][0] == icon) ||
          (board[1][3] == icon && board[2][2] == icon && board[3][1] == icon)) {
        return true;
      }
    } else if (board.length == 5 && n == 4) {
      // 5by5 && 승리조건 4 특이 케이스
      if ((board[0][1] == icon &&
              board[1][2] == icon &&
              board[2][3] == icon &&
              board[3][4] == icon) ||
          (board[1][0] == icon &&
              board[2][1] == icon &&
              board[3][2] == icon &&
              board[4][3] == icon) ||
          (board[0][3] == icon &&
              board[1][2] == icon &&
              board[2][1] == icon &&
              board[3][0] == icon) ||
          (board[1][4] == icon &&
              board[2][3] == icon &&
              board[3][2] == icon &&
              board[4][1] == icon)) {
        return true;
      }
    } else if (board.length == 5 && n == 3) {
      // 5by5 && 승리조건 3 특이 케이스
      if ((board[0][2] == icon && board[1][1] == icon && board[2][0] == icon) ||
          (board[0][3] == icon && board[1][2] == icon && board[2][1] == icon) ||
          (board[1][2] == icon && board[2][1] == icon && board[3][0] == icon) ||
          (board[1][4] == icon && board[2][3] == icon && board[3][2] == icon) ||
          (board[2][3] == icon && board[3][2] == icon && board[4][1] == icon) ||
          (board[2][4] == icon && board[3][3] == icon && board[4][2] == icon) ||
          ////
          (board[0][2] == icon && board[1][3] == icon && board[2][4] == icon) ||
          (board[0][1] == icon && board[1][2] == icon && board[2][3] == icon) ||
          (board[1][2] == icon && board[2][3] == icon && board[3][4] == icon) ||
          (board[1][0] == icon && board[2][1] == icon && board[3][2] == icon) ||
          (board[2][1] == icon && board[3][2] == icon && board[4][3] == icon) ||
          (board[2][0] == icon && board[3][1] == icon && board[4][2] == icon)) {
        return true;
      }
    }
    return false;
  }

  // 빈 칸 체크
  bool _isAnyEmptyBox(List<List<IconData>> board) {
    for (int i = 0; i < gridCount; i++) {
      for (int j = 0; j < gridCount; j++) {
        if (board[i][j] == Icons.abc) {
          return true;
        }
      }
    }
    return false;
  }

  // db에 저장
  Future<void> saveRecord() async {
    DatabaseHandler handler = DatabaseHandler();
    RecordModel record = RecordModel(
        boardSize: gridCount,
        recordData: jsonEncode(recordData),
        playerOneIconCode: RecordModel.getPlayerIconCode(playerOneMarker),
        playerTwoIconCode: RecordModel.getPlayerIconCode(playerTwoMarker),
        playerOneColorIndex: RecordModel.getPlayerColorIndex(playerOneColor),
        playerTwoColorIndex: RecordModel.getPlayerColorIndex(playerTwoColor),
        isPlayerOneStartFirst: isPlayerOneStartFirst ? 1 : 0,
        align: alignCount,
        playerOneRemainBackies: playerOneBackCount,
        playerTwoRemainBackies: playerTwoBackCount,
        dateTime: DateTime.now().toString(),
        result: result);

    await handler.insertRecord(record);
  }
}
