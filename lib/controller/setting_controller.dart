import 'package:get/get.dart';
import 'package:tic_tac_toe_app/constant/enums.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';
import 'package:tic_tac_toe_app/util/error_snackbar.dart';

class SettingController extends GetxController {
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
      update();
    }
  }

  void setAlign(AlignOpt? value) {
    if (value != null) {
      bool isValid = _isAlignValid(_gridSegmentValue, value);
      if (isValid) {
        _alignSegmentValue = value;
      } else {
        showErrorSnackBar(
          title: '불가능',
          message: '게임판 크기를 벗어난 승리조건입니다!!',
        );
      }
      update();
    }
  }

  void setMarker({required MarkerOpt? value, required bool isFirstMarker}) {
    if (value != null) {
      bool isValid =
          _isMarkerValid(_markerOneSegmentValue, _markerTwoSegmentValue, value);
      if (isValid) {
        if (isFirstMarker) {
          _markerOneSegmentValue = value;
        } else {
          _markerTwoSegmentValue = value;
        }
      } else {
        showErrorSnackBar(
          title: '불가능',
          message: '상대방과 동일한 마커는 선택 불가능합니다.',
        );
      }
      update();
    }
  }

  void setColor({required ColorOpt? value, required bool isFirstColor}) {
    if (value != null) {
      bool isValid =
          _isColorValid(_colorOneSegmentValue, _colorTwoSegmentValue, value);
      if (isValid) {
        if (isFirstColor) {
          _colorOneSegmentValue = value;
        } else {
          _colorTwoSegmentValue = value;
        }
      } else {
        showErrorSnackBar(
          title: '불가능',
          message: '상대방과 동일한 색상은 선택 불가능합니다.',
        );
      }
      update();
    }
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

  // gameController에 전달하기 위한 setting 모델 생성.
  SettingModel getCurrentSetting() {
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

  bool _isAlignValid(GridOpt gridOpt, AlignOpt alignOpt) {
    switch (gridOpt) {
      // 3x3 : align 선택 불가능
      case GridOpt.threeByThree:
        return false;
      // 4x4 : alignOpt가 5가 아닐 때 (3,4) 가능
      case GridOpt.fourByFour:
        return alignOpt != AlignOpt.five;
      // align 선택 제한 없음
      case GridOpt.fiveByFive:
        return true;
    }
  }

  bool _isMarkerValid(MarkerOpt markerOneSegmentValue,
      MarkerOpt markerTwoSegmentValue, MarkerOpt value) {
    return (value != markerTwoSegmentValue) && (value != markerOneSegmentValue);
  }

  bool _isColorValid(ColorOpt colorOneSegmentValue,
      ColorOpt colorTwoSegmentValue, ColorOpt value) {
    return (value != colorTwoSegmentValue) && (value != colorOneSegmentValue);
  }
}
