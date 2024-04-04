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
  setAlign(int value){
    alignCount = value;
  }
  setPlayerOneMarker(IconData value){
    playerOneMarker = value;
  }
  setPlayerTwoMarker(IconData value){
    playerTwoMarker = value;
  }
  setPlayerOneColor(Color value){
    playerOneColor = value;
  }
  setPlayerTwoColor(Color value){
    playerTwoColor = value;
  }

}
