import 'package:tic_tac_toe_app/common/enums.dart';

mixin SettingValidatorMixin {
  bool isAlignValid(GridOpt gridOpt, AlignOpt alignOpt) {
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

  bool isMarkerValid(MarkerOpt markerOneSegmentValue,
      MarkerOpt markerTwoSegmentValue, MarkerOpt value) {
    return (value != markerTwoSegmentValue) || (value != markerOneSegmentValue);
  }

  bool isColorValid(ColorOpt colorOneSegmentValue,
      ColorOpt colorTwoSegmentValue, ColorOpt value) {
    return (value != colorTwoSegmentValue) || (value != colorOneSegmentValue);
  }
}
