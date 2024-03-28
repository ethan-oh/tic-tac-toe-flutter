import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/constants.dart';
import 'package:tic_tac_toe_app/screens/game_screen.dart';
import 'package:tic_tac_toe_app/controllers/game_controller.dart';
import 'package:tic_tac_toe_app/controllers/setting_controller.dart';
import 'package:tic_tac_toe_app/widgets/setting/segment_widgets.dart';
import 'package:tic_tac_toe_app/utils/error_snackbar.dart';
import 'package:tic_tac_toe_app/widgets/simple_button.dart';

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _gridSetting(),
              _alignSetting(),
              _markerSetting(isPlayerOne: true),
              _markerSetting(isPlayerOne: false),
              _turnSetting(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _startButton(),
    );
  }

  Widget _startButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleButton(
          title: '게임 시작',
          height: 60,
          color: Colors.indigo[900],
          onPressed: () => Get.to(
            () => GameScreen(
              settings: controller.retriveCurrentSetting(),
            ),
            binding: BindingsBuilder(() {
              Get.put(GameController(controller.retriveCurrentSetting()));
            }),
            transition: Transition.zoom,
          ),
        ),
      ),
    );
  }

  Column _turnSetting() {
    return Column(
      children: [
        _settingTitle('선공'),
        GetBuilder<SettingController>(
          builder: (_) => CupertinoSlidingSegmentedControl(
            groupValue: controller.turnSegmentValue,
            onValueChanged: (value) => controller.setTurn(value),
            children: {
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
          builder: (_) => CupertinoSlidingSegmentedControl(
            thumbColor: isPlayerOne
                ? controller.colorOneSegmentValue.value
                : controller.colorTwoSegmentValue.value,
            groupValue: isPlayerOne
                ? controller.markerOneSegmentValue
                : controller.markerTwoSegmentValue,
            onValueChanged: (value) {
              bool isImpossible = isPlayerOne
                  ? controller.setMarker(
                      value: value,
                      isFirstMarker: true,
                    )
                  : controller.setMarker(
                      value: value,
                      isFirstMarker: false,
                    );
              if (isImpossible) {
                showErrorSnackBar(
                  title: '불가능',
                  message: '상대방과 동일한 마커는 선택 불가능합니다.',
                );
              }
            },
            children: {
              MarkerOpt.cross: iconSegmentWidget(Icons.close),
              MarkerOpt.circle: iconSegmentWidget(Icons.circle_outlined),
              MarkerOpt.triangle: iconSegmentWidget(Icons.change_history),
              MarkerOpt.rectangle: iconSegmentWidget(Icons.square_outlined),
            },
          ),
        ),
        GetBuilder<SettingController>(
          builder: (_) => CupertinoSlidingSegmentedControl(
            groupValue: isPlayerOne
                ? controller.colorOneSegmentValue
                : controller.colorTwoSegmentValue,
            onValueChanged: (value) {
              bool isImpossible = isPlayerOne
                  ? controller.setColor(
                      value: value,
                      isFirstColor: true,
                    )
                  : controller.setColor(
                      value: value,
                      isFirstColor: false,
                    );
              if (isImpossible) {
                showErrorSnackBar(
                  title: '불가능',
                  message: '상대방과 동일한 색상은 선택 불가능합니다.',
                );
              }
            },
            children: {
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
          builder: (_) => CupertinoSlidingSegmentedControl(
            groupValue: controller.alignSegmentValue,
            onValueChanged: (value) {
              bool isImpossible = controller.setAlign(value);
              if (isImpossible) {
                showErrorSnackBar(title: '불가능', message: '게임판 크기를 벗어난 승리조건입니다!!');
              }
            },
            children: {
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
          builder: (_) => CupertinoSlidingSegmentedControl(
            groupValue: controller.gridSegmentValue,
            onValueChanged: (value) => controller.setGrid(value),
            children: {
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
      onPressed: () => controller.resetSetting(),
      icon: const Icon(
        Icons.refresh,
      ),
    );
  }
}

Widget _settingTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 10),
    child: Text(
      title,
      style: settingTitleStyle,
    ),
  );
}
