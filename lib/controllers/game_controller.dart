import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/constants.dart';
import 'package:tic_tac_toe_app/models/db_helper.dart';
import 'package:tic_tac_toe_app/models/record_model.dart';
import 'package:tic_tac_toe_app/models/setting_model.dart';


class GameController extends GetxController {
  final SettingModel settings;
  GameController(this.settings);

  @override
  void onInit() {
    super.onInit();
    _loadSetting();
    _gameInit();
  }

  // setting model을 통해 받아온 설정값을 변수에 저장
  late final IconData playerOneMarker;
  late final IconData playerTwoMarker;
  late final Color playerOneColor;
  late final Color playerTwoColor;
  late final int gridCount;
  late final int alignCount;

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
  // 기록 저장을 위한 좌표값 Map. ex) {'(1,1)' : 3}
  late Map<String, int> recordData;
  // 놓은 순서 저장 위한 변수
  late int index;
  late bool isPlayerOneStartFirst;
  late String result;

  /////////////////////////// 게임 세팅 /////////////////////////////////
  void _gameInit() {
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
    resultMessage = '경기중';
    _iconListInit(); // 이중 아이콘 배열 Icons.abc로 초기화
    _recordDataInit(); // 순서 저장할 map 초기화
  }

  void _loadSetting() {
    playerOneMarker = settings.playerOneMarker;
    playerTwoMarker = settings.playerTwoMarker;
    playerOneColor = settings.playerOneColor;
    playerTwoColor = settings.playerTwoColor;
    gridCount = settings.gridCount;
    alignCount = settings.alignCount;
  }

  void _recordDataInit() {
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
    _gameInit();
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

    await DBHelper.insertRecord(record);
  }

  /// 경기 중 메뉴 버튼 선택 시
  void showMenu() {
    if (!isGameFinish()) {
      gameStatus = GameStatus.pause;
    }else{
      if (result == '무승부'){
        gameStatus = GameStatus.draw;
      } 
      if (result == 'Player 1 승리'){
        gameStatus = GameStatus.playerOneWin;
      } 
      if (result == 'Player 2 승리'){
        gameStatus = GameStatus.playerTwoWin;
      } 
    }
    update();
  }

  /// 메뉴에서 돌아가기 or 결과 보기 클릭 시 액션. end일 때는 메뉴를 숨김
  void hideMenu() {
    if (gameStatus == GameStatus.pause) {
      gameStatus = GameStatus.playing;
    } else {
      gameStatus = GameStatus.end;
    }
    update();
  }

  /// 게임이 끝났는지 체크. 놓은 순서를 보일지 판단하기 위해 사용.
  bool isGameFinish() {
    return gameStatus == GameStatus.draw ||
            gameStatus == GameStatus.playerOneWin ||
            gameStatus == GameStatus.playerTwoWin ||
            gameStatus == GameStatus.end
        ? true
        : false;
  }

  /// 게임중이거나 결과 확인중이면 메뉴를 보이지 않는다.
  bool isMenuVisible() {
    return gameStatus == GameStatus.playing || gameStatus == GameStatus.end
        ? false
        : true;
  }
}
