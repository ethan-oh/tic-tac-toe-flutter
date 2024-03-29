import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/constant/enums.dart';

class SettingModel {
  final int gridCount;
  final int alignCount;
  final IconData playerOneMarker;
  final Color playerOneColor;
  final IconData playerTwoMarker;
  final Color playerTwoColor;
  final TurnOpt firstPlayer;

  SettingModel({
    required this.gridCount,
    required this.alignCount,
    required this.playerOneMarker,
    required this.playerOneColor,
    required this.playerTwoMarker,
    required this.playerTwoColor,
    required this.firstPlayer,
  });
}
