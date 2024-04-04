import 'package:get/get.dart';
import 'package:tic_tac_toe_app/constant/enums.dart';
import 'package:tic_tac_toe_app/model/setting_model.dart';
import 'package:tic_tac_toe_app/util/error_snackbar.dart';

class SettingController extends GetxController {
  // default 값 세팅
  final Rx<TurnOpt> _turn = TurnOpt.random.obs;
  final Rx<GridOpt> _grid = GridOpt.threeByThree.obs;
  final Rx<AlignOpt> _align = AlignOpt.three.obs;
  final Rx<MarkerOpt> _playerOneMarker = MarkerOpt.cross.obs;
  final Rx<MarkerOpt> _playerTwomarker = MarkerOpt.circle.obs;
  final Rx<ColorOpt> _playerOneColor = ColorOpt.blue.obs;
  final Rx<ColorOpt> _playerTwoColor = ColorOpt.red.obs;

  // getter
  TurnOpt get turn => _turn.value;
  GridOpt get grid => _grid.value;
  AlignOpt get align => _align.value;
  MarkerOpt get playerOneMarker => _playerOneMarker.value;
  MarkerOpt get playerTwomarker => _playerTwomarker.value;
  ColorOpt get playerOneColor => _playerOneColor.value;
  ColorOpt get playerTwoColor => _playerTwoColor.value;

  void setGrid(GridOpt? value) {
    if (value != null) {
      _align.value = AlignOpt.three;
      _grid.value = value;
      // 그리드 선택에 따른 승리 조건 제한
      
    }
  }

  void setTurn(TurnOpt? value) {
    if (value != null) {
      _turn.value = value;
    }
  }

  void setAlign(AlignOpt? value) {
    if (value != null) {
      bool isValid = _isAlignValid(_grid.value, value);
      if (isValid) {
        _align.value = value;
      } else {
        Get.forceAppUpdate();
        showErrorSnackBar(
          title: '불가능',
          message: '게임판 크기를 벗어난 승리조건입니다!!',
        );
      }
    }
  }

  void setMarker({required MarkerOpt? value, required bool isFirstMarker}) {
    if (value != null) {
      bool isValid =
          (value != playerOneMarker) && (value != playerTwomarker);
      if (isValid) {
        if (isFirstMarker) {
          _playerOneMarker.value = value;
        } else {
          _playerTwomarker.value = value;
        }
      } else {
        Get.forceAppUpdate();
        showErrorSnackBar(
          title: '불가능',
          message: '상대방과 동일한 마커는 선택 불가능합니다.',
        );
      }
    }
  }

  void setColor({required ColorOpt? value, required bool isFirstColor}) {
    if (value != null) {
      bool isValid =
          (value != playerOneColor) && (value != playerTwoColor);
      if (isValid) {
        if (isFirstColor) {
          _playerOneColor.value = value;
        } else {
          _playerTwoColor.value = value;
        }
      } else {
        Get.forceAppUpdate();
        showErrorSnackBar(
          title: '불가능',
          message: '상대방과 동일한 색상은 선택 불가능합니다.',
        );
      }
    }
  }

  void resetSetting() {
    _grid.value = GridOpt.threeByThree;
    _align.value = AlignOpt.three;
    _playerOneMarker.value = MarkerOpt.cross;
    _playerTwomarker.value = MarkerOpt.circle;
    _playerOneColor.value = ColorOpt.blue;
    _playerTwoColor.value = ColorOpt.red;
    _turn.value = TurnOpt.random;
  }

  // gameController에 전달하기 위한 setting 모델 생성.
  GameSetting getCurrentSetting() {
    return GameSetting(
      gridCount: _grid.value.grid,
      alignCount: _align.value.align,
      playerOneMarker: _playerOneMarker.value.marker,
      playerOneColor: _playerOneColor.value.color,
      playerTwoMarker: _playerTwomarker.value.marker,
      playerTwoColor: _playerTwoColor.value.color,
      firstPlayer: _turn.value,
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
}
