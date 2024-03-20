import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/enums.dart';
import 'package:tic_tac_toe_app/common/font_style.dart';
import 'package:tic_tac_toe_app/view/game/game_screen.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/controller/setting_controller.dart';
import 'package:tic_tac_toe_app/view/setting/segment_widgets.dart';
import 'package:tic_tac_toe_app/widget/error_snackbar.dart';
import 'package:tic_tac_toe_app/widget/simple_button.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '게임 규칙 설정',
        ),
        actions: [
          _resetButton(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _gridSetting(),
              _alignSetting(),
              _markerSetting(isPlayerOne: true),
              _markerSetting(isPlayerOne: false),
              _turnSetting(),
              _startButton(),
            ],
          ),
        ),
      ),
    );
  }

  SimpleButton _startButton() {
    return SimpleButton(
      title: '게임 시작',
      width: double.maxFinite,
      height: 60,
      color: Colors.indigo[900],
      onPressed: () => Get.to(
        () => GameScreen(
          settings: controller.getSettingModel(),
        ),
        binding: BindingsBuilder(() {
          Get.put(GameController(controller.getSettingModel()));
        }),
        transition: Transition.zoom,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  Column _turnSetting() {
    return Column(
      children: [
        _settingTitle('선공'),
        GetBuilder<SettingController>(
          builder: (_) => CupertinoSlidingSegmentedControl<TurnOpt>(
            groupValue: controller.turnSegmentValue,
            onValueChanged: (value) => controller.selectTurn(value),
            children: <TurnOpt, Widget>{
              TurnOpt.random: segmentWidget(
                '랜덤',
              ),
              TurnOpt.playerOne: segmentWidget('Player 1'),
              TurnOpt.playerTwo: segmentWidget('Player 2'),
            },
          ),
        ),
      ],
    );
  }

  Column _markerSetting({required bool isPlayerOne}) {
    return Column(
      children: [
        _settingTitle('Player ${isPlayerOne ? '1' : '2'} 마커'),
        GetBuilder<SettingController>(
          builder: (_) => CupertinoSlidingSegmentedControl<MarkerOpt>(
            thumbColor: isPlayerOne
                ? controller.colorOneSegmentValue.color
                : controller.colorTwoSegmentValue.color,
            groupValue: isPlayerOne
                ? controller.markerOneSegmentValue
                : controller.markerTwoSegmentValue,
            onValueChanged: (value) {
              bool isImpossible = isPlayerOne
                  ? controller.selectMarker(
                      value: value,
                      isFirstMarker: true,
                    )
                  : controller.selectMarker(
                      value: value,
                      isFirstMarker: false,
                    );
              if (isImpossible) {
                errorSnackBar(
                  title: '불가능',
                  message: '상대방과 동일한 마커는 선택 불가능합니다.',
                );
              }
            },
            children: <MarkerOpt, Widget>{
              MarkerOpt.cross: iconSegmentWidget(Icons.close),
              MarkerOpt.circle: iconSegmentWidget(Icons.circle_outlined),
              MarkerOpt.triangle: iconSegmentWidget(Icons.change_history),
              MarkerOpt.rectangle: iconSegmentWidget(Icons.square_outlined),
            },
          ),
        ),
        GetBuilder<SettingController>(
          builder: (_) => CupertinoSlidingSegmentedControl<ColorOpt>(
            groupValue: isPlayerOne
                ? controller.colorOneSegmentValue
                : controller.colorTwoSegmentValue,
            onValueChanged: (value) {
              bool isImpossible = isPlayerOne
                  ? controller.selectColor(
                      value: value,
                      isFirstColor: true,
                    )
                  : controller.selectColor(
                      value: value,
                      isFirstColor: false,
                    );
              if (isImpossible) {
                errorSnackBar(
                  title: '불가능',
                  message: '상대방과 동일한 색상은 선택 불가능합니다.',
                );
              }
            },
            children: <ColorOpt, Widget>{
              ColorOpt.blue: colorSegmentWidget(Colors.indigo),
              ColorOpt.red: colorSegmentWidget(const Color(0xFFD32F2F)),
              ColorOpt.green: colorSegmentWidget(Colors.green),
              ColorOpt.orange: colorSegmentWidget(Colors.orange),
            },
          ),
        ),
      ],
    );
  }

  Column _alignSetting() {
    return Column(
      children: [
        _settingTitle('승리 조건'),
        GetBuilder<SettingController>(
          builder: (_) => CupertinoSlidingSegmentedControl<AlignOpt>(
            groupValue: controller.alignSegmentValue,
            onValueChanged: (value) {
              bool isImpossible = controller.selectAlign(value);
              if (isImpossible) {
                Get.closeAllSnackbars(); // 여러 번 클릭해도 한 번만 보이게 미리 닫는다
                const GetSnackBar(
                  title: '불가능',
                  message: '게임판 크기를 벗어난 승리조건입니다!!',
                  duration: Duration(milliseconds: 1200),
                  icon: Icon(
                    Icons.dangerous,
                    color: Colors.red,
                    size: 30,
                  ),
                ).show();
              }
            },
            children: <AlignOpt, Widget>{
              AlignOpt.three: segmentWidget('3칸'),
              AlignOpt.four: segmentWidget('4칸'),
              AlignOpt.five: segmentWidget('5칸'),
            },
          ),
        ),
      ],
    );
  }

  Column _gridSetting() {
    return Column(
      children: [
        _settingTitle('게임판 크기'),
        GetBuilder<SettingController>(
          builder: (_) => CupertinoSlidingSegmentedControl<GridOpt>(
            groupValue: controller.gridSegmentValue,
            onValueChanged: (value) => controller.selectGrid(value),
            children: <GridOpt, Widget>{
              GridOpt.threeByThree: segmentWidget('3 X 3'),
              GridOpt.fourByFour: segmentWidget('4 X 4'),
              GridOpt.fiveByFive: segmentWidget('5 X 5'),
            },
          ),
        ),
      ],
    );
  }

  IconButton _resetButton() {
    return IconButton(
      onPressed: () => controller.resetValues(),
      icon: const Icon(
        Icons.refresh,
      ),
    );
  }
}

Widget _settingTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(
      title,
      style: AppStyle.settingTitleStyle,
    ),
  );
}
