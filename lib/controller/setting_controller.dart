import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/enums.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';


class SettingController extends GetxController {
  TurnOpt turnSegmentValue = TurnOpt.random;
  GridOpt gridSegmentValue = GridOpt.threeByThree;
  AlignOpt alignSegmentValue = AlignOpt.three;
  MarkerOpt markerOneSegmentValue = MarkerOpt.cross; // Player 1의 마커 선택
  MarkerOpt markerTwoSegmentValue = MarkerOpt.circle; // Player 2의 마커 선택
  ColorOpt colorOneSegmentValue = ColorOpt.blue; // Player 2의 마커 선택
  ColorOpt colorTwoSegmentValue = ColorOpt.red; // Player 2의 마커 선택

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
          } else {
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
    if (value != null && value != markerTwoSegmentValue) {
      markerOneSegmentValue = value;
    }
    update();
  }

  selectMarker2(MarkerOpt? value) {
    if (value != null && value != markerOneSegmentValue) {
      markerTwoSegmentValue = value;
    }
    update();
  }

  selectColor1(ColorOpt? value) {
    if (value != null && value != colorTwoSegmentValue) {
      colorOneSegmentValue = value;
    }
    update();
  }

  selectColor2(ColorOpt? value) {
    if (value != null && value != colorOneSegmentValue) {
      colorTwoSegmentValue = value;
    }
    update();
  }

  resetValues() {
    gridSegmentValue = GridOpt.threeByThree;
    alignSegmentValue = AlignOpt.three;
    markerOneSegmentValue = MarkerOpt.cross; // Player 1의 마커 선택
    markerTwoSegmentValue = MarkerOpt.circle; // Player 2의 마커 선택
    colorOneSegmentValue = ColorOpt.blue;
    colorTwoSegmentValue = ColorOpt.red;
    turnSegmentValue = TurnOpt.random;
    update();
  }

  SettingModel getSettingModel() {
    return SettingModel(
      gridCount: gridSegmentValue.gridCount,
      alignCount: alignSegmentValue.alignCount,
      playerOneMarker: markerOneSegmentValue.marker,
      playerOneColor: colorOneSegmentValue.color,
      playerTwoMarker: markerTwoSegmentValue.marker,
      playerTwoColor: colorTwoSegmentValue.color,
      firstPlayer: turnSegmentValue,
    );
  }
}
