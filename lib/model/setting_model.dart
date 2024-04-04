import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/constant/enums.dart';

class GameSetting {
  int gridCount;
  int alignCount;
  IconData playerOneMarker;
  Color playerOneColor;
  IconData playerTwoMarker;
  Color playerTwoColor;
  TurnOpt firstPlayer;

  GameSetting({
    required this.gridCount,
    required this.alignCount,
    required this.playerOneMarker,
    required this.playerOneColor,
    required this.playerTwoMarker,
    required this.playerTwoColor,
    required this.firstPlayer,
  });

  setGrid(int value){
    gridCount = value;
  }
}
