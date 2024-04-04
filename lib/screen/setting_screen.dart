import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/constant/enums.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';
import 'package:tic_tac_toe_app/screen/game_screen.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/controller/setting_controller.dart';
import 'package:tic_tac_toe_app/widget/setting/segment_widgets.dart';
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
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
              settings: controller.getCurrentSetting(),
            ),
            binding: BindingsBuilder(() {
              Get.put(GameController(controller.getCurrentSetting()));
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
        Obx(
          () => CupertinoSlidingSegmentedControl(
            groupValue: controller.turn,
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
        Obx(
          () => CupertinoSlidingSegmentedControl(
            thumbColor: isPlayerOne
                ? controller.playerOneColor.color
                : controller.playerTwoColor.color,
            groupValue: isPlayerOne
                ? controller.playerOneMarker
                : controller.playerTwomarker,
            onValueChanged: (value) => isPlayerOne
                ? controller.setMarker(
                    value: value,
                    isFirstMarker: true,
                  )
                : controller.setMarker(
                    value: value,
                    isFirstMarker: false,
                  ),
            children: {
              MarkerOpt.cross: iconSegmentWidget(Icons.close),
              MarkerOpt.circle: iconSegmentWidget(Icons.circle_outlined),
              MarkerOpt.triangle: iconSegmentWidget(Icons.change_history),
              MarkerOpt.rectangle: iconSegmentWidget(Icons.square_outlined),
            },
          ),
        ),
        Obx(
          () => CupertinoSlidingSegmentedControl(
            groupValue: isPlayerOne
                ? controller.playerOneColor
                : controller.playerTwoColor,
            backgroundColor: Colors.grey,
            onValueChanged: (value) => isPlayerOne
                ? controller.setColor(
                    value: value,
                    isFirstColor: true,
                  )
                : controller.setColor(
                    value: value,
                    isFirstColor: false,
                  ),
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
        Obx(
          () => CupertinoSlidingSegmentedControl(
            groupValue: controller.align,
            onValueChanged: (value) => controller.setAlign(value),
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
        Obx(
          () => CupertinoSlidingSegmentedControl(
            groupValue: controller.grid,
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
