import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/enums.dart';
import 'package:tic_tac_toe_app/controller/setting_validator_mixin.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';

class SettingController extends GetxController with SettingValidatorMixin {
  // default 값 세팅
  TurnOpt _turnSegmentValue = TurnOpt.random;
  GridOpt _gridSegmentValue = GridOpt.threeByThree;
  AlignOpt _alignSegmentValue = AlignOpt.three;
  MarkerOpt _markerOneSegmentValue = MarkerOpt.cross;
  MarkerOpt _markerTwoSegmentValue = MarkerOpt.circle;
  ColorOpt _colorOneSegmentValue = ColorOpt.blue;
  ColorOpt _colorTwoSegmentValue = ColorOpt.red;

  // getter
  TurnOpt get turnSegmentValue => _turnSegmentValue;
  GridOpt get gridSegmentValue => _gridSegmentValue;
  AlignOpt get alignSegmentValue => _alignSegmentValue;
  MarkerOpt get markerOneSegmentValue => _markerOneSegmentValue;
  MarkerOpt get markerTwoSegmentValue => _markerTwoSegmentValue;
  ColorOpt get colorOneSegmentValue => _colorOneSegmentValue;
  ColorOpt get colorTwoSegmentValue => _colorTwoSegmentValue;

  void setGrid(GridOpt? value) {
    if (value != null) {
      _alignSegmentValue = AlignOpt.three;
      _gridSegmentValue = value;
      // 그리드 선택에 따른 승리 조건 제한
      update();
    }
  }

  void setTurn(TurnOpt? value) {
    if (value != null) {
      _turnSegmentValue = value;
      // 그리드 선택에 따른 승리 조건 제한
      update();
    }
  }

  bool setAlign(AlignOpt? value) {
    if (value != null) {
      bool isValid = isAlignValid(_gridSegmentValue, value);
      if (isValid) {
        _alignSegmentValue = value;
        update();
      }
      return !isValid;
    }
    return false;
  }

  bool setMarker({required MarkerOpt? value, required bool isFirstMarker}) {
    if (value != null) {
      bool isValid = isMarkerValid(
          _markerOneSegmentValue, _markerTwoSegmentValue, value);
      if (isValid) {
        if (isFirstMarker) {
          _markerOneSegmentValue = value;
        } else {
          _markerTwoSegmentValue = value;
        }
        update();
      }
      return !isValid;
    }
    return false;
  }

  bool setColor({required ColorOpt? value, required bool isFirstColor}) {
    if (value != null) {
      bool isValid = isColorValid(
          _colorOneSegmentValue, _colorTwoSegmentValue, value);
      if (isValid) {
        if (isFirstColor) {
          _colorOneSegmentValue = value;
        } else {
          _colorTwoSegmentValue = value;
        }
        update();
      }
      return !isValid;
    }
    return false;
  }


  void resetSetting() {
    _gridSegmentValue = GridOpt.threeByThree;
    _alignSegmentValue = AlignOpt.three;
    _markerOneSegmentValue = MarkerOpt.cross;
    _markerTwoSegmentValue = MarkerOpt.circle;
    _colorOneSegmentValue = ColorOpt.blue;
    _colorTwoSegmentValue = ColorOpt.red;
    _turnSegmentValue = TurnOpt.random;
    update();
  }

  SettingModel retriveCurrentSetting() {
    return SettingModel(
      gridCount: _gridSegmentValue.value,
      alignCount: _alignSegmentValue.value,
      playerOneMarker: _markerOneSegmentValue.value,
      playerOneColor: _colorOneSegmentValue.value,
      playerTwoMarker: _markerTwoSegmentValue.value,
      playerTwoColor: _colorTwoSegmentValue.value,
      firstPlayer: _turnSegmentValue,
    );
  }
}
