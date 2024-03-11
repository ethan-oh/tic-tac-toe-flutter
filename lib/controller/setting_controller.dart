import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';

enum GridOpt { threeByThree, fourByFour, fiveByFive }
enum AlignOpt { three, four, five }
enum MarkerOpt { circle, cross, triangle, rectangle }
enum ColorOpt { blue, red, green, orange }
enum TurnOpt { random, playerOne, playerTwo}

class SettingController extends GetxController {
  TurnOpt turnSegmentValue = TurnOpt.random;
  GridOpt gridSegmentValue = GridOpt.threeByThree;
  AlignOpt alignSegmentValue = AlignOpt.three;
  MarkerOpt marker1 = MarkerOpt.cross; // Player 1의 마커 선택
  MarkerOpt marker2 = MarkerOpt.circle; // Player 2의 마커 선택
  ColorOpt color1 = ColorOpt.blue; // Player 2의 마커 선택
  ColorOpt color2 = ColorOpt.red; // Player 2의 마커 선택

  selectGrid(GridOpt? value) {
    if (value != null) {
      alignSegmentValue = AlignOpt.three;
      gridSegmentValue = value;
      // 그리드 선택에 따른 승리 조건 제한
      update();
    }
  }

  selectTurn(TurnOpt? value) {
    if (value != null) {
      turnSegmentValue = value;
      // 그리드 선택에 따른 승리 조건 제한
      update();
    }
  }

  bool selectAlign(AlignOpt? value) {
    bool isImpossibleCondition = false;
    if (value != null) {
      switch (gridSegmentValue) {
        case GridOpt.threeByThree:
          isImpossibleCondition = true;
          break;
        case GridOpt.fourByFour:
          if (value != AlignOpt.five) {
            alignSegmentValue = value;
          }else{
            isImpossibleCondition = true;
          }
        break;
        case GridOpt.fiveByFive:
          alignSegmentValue = value;
      }
      update();
    }
    return isImpossibleCondition;
  }

  selectMarker1(MarkerOpt? value) {
    if (value != null && value != marker2) {
      marker1 = value;
    }
    update();
  }

  selectMarker2(MarkerOpt? value) {
    if (value != null && value != marker1) {
      marker2 = value;
    }
    update();
  }

  selectColor1(ColorOpt? value) {
    if (value != null && value != color2) {
      color1 = value;
    }
    update();
  }

  selectColor2(ColorOpt? value) {
    if (value != null && value != color1) {
      color2 = value;
    }
    update();
  }

  Color getColor(ColorOpt colorOpt) {
    switch (colorOpt) {
      case ColorOpt.blue:
        return Colors.indigo;
      case ColorOpt.red:
        return Colors.red[700]!;
      case ColorOpt.green:
        return Colors.green;
      case ColorOpt.orange:
        return Colors.orange;
    }
  }

  resetValues() {
    gridSegmentValue = GridOpt.threeByThree;
    alignSegmentValue = AlignOpt.three;
    marker1 = MarkerOpt.cross; // Player 1의 마커 선택
    marker2 = MarkerOpt.circle; // Player 2의 마커 선택
    color1 = ColorOpt.blue;
    color2 = ColorOpt.red;
    turnSegmentValue = TurnOpt.random;
    update();
  }

  SettingModel getSettings() {
    return SettingModel(
      gridOpt: gridSegmentValue,
      alignOpt: alignSegmentValue,
      player1Marker: marker1,
      player1Color: color1,
      player2Marker: marker2,
      player2Color: color2,
      firstPlayer: turnSegmentValue,
    );
  }
}
