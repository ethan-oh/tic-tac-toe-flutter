import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/%08common/button.dart';
import 'package:tic_tac_toe_app/%08common/font_style.dart';
import 'package:tic_tac_toe_app/view/game/game_screen.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/controller/setting_controller.dart';
import 'package:tic_tac_toe_app/view/setting/segment_widget.dart';

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
          IconButton(
            onPressed: () => controller.resetValues(),
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              settingTitle('게임판 크기'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<SettingController>(
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
              ),
              const Spacer(),
              settingTitle('승리 조건'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<SettingController>(
                  builder: (_) => CupertinoSlidingSegmentedControl<AlignOpt>(
                    groupValue: controller.alignSegmentValue,
                    onValueChanged: (value) {
                      bool isImpossible = controller.selectAlign(value);
                      if (isImpossible) {
                        Get.closeAllSnackbars(); // 여러 번 클릭해도 한 번만 보이게 미리 닫는다
                        const GetSnackBar(
                          title: '불가능',
                          message: '게임판 크기를 벗어난 승리조건입니다!!',
                          duration: const Duration(milliseconds: 1200),
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
              ),
              const Spacer(),
              settingTitle('Player 1 마커'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GetBuilder<SettingController>(
                      builder: (_) =>
                          CupertinoSlidingSegmentedControl<MarkerOpt>(
                        thumbColor: controller.getColor(controller.color1),
                        groupValue: controller.marker1,
                        onValueChanged: (value) =>
                            controller.selectMarker1(value),
                        children: <MarkerOpt, Widget>{
                          MarkerOpt.cross: segmentIconWidget(Icons.close),
                          MarkerOpt.circle:
                              segmentIconWidget(Icons.circle_outlined),
                          MarkerOpt.triangle:
                              segmentIconWidget(Icons.change_history),
                          MarkerOpt.rectangle:
                              segmentIconWidget(Icons.square_outlined),
                        },
                      ),
                    ),
                  ),
                  GetBuilder<SettingController>(
                    builder: (_) => CupertinoSegmentedControl<ColorOpt>(
                      borderColor: Colors.transparent,
                      selectedColor: Colors.white,
                      unselectedColor: Colors.grey,
                      groupValue: controller.color1,
                      onValueChanged: (value) => controller.selectColor1(value),
                      children: <ColorOpt, Widget>{
                        ColorOpt.blue: segmentColorWidget(Colors.indigo),
                        ColorOpt.red: segmentColorWidget(Colors.red[700]!),
                        ColorOpt.green: segmentColorWidget(Colors.green),
                        ColorOpt.orange: segmentColorWidget(Colors.orange),
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              settingTitle('Player 2 마커'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GetBuilder<SettingController>(
                      builder: (_) =>
                          CupertinoSlidingSegmentedControl<MarkerOpt>(
                        thumbColor: controller.getColor(controller.color2),
                        groupValue: controller.marker2,
                        onValueChanged: (value) =>
                            controller.selectMarker2(value),
                        children: <MarkerOpt, Widget>{
                          MarkerOpt.cross: segmentIconWidget(Icons.close),
                          MarkerOpt.circle:
                              segmentIconWidget(Icons.circle_outlined),
                          MarkerOpt.triangle:
                              segmentIconWidget(Icons.change_history),
                          MarkerOpt.rectangle:
                              segmentIconWidget(Icons.square_outlined),
                        },
                      ),
                    ),
                  ),
                  GetBuilder<SettingController>(
                    builder: (_) => CupertinoSegmentedControl<ColorOpt>(
                      borderColor: Colors.transparent,
                      selectedColor: Colors.white,
                      unselectedColor: Colors.grey,
                      groupValue: controller.color2,
                      onValueChanged: (value) => controller.selectColor2(value),
                      children: <ColorOpt, Widget>{
                        ColorOpt.blue: segmentColorWidget(Colors.indigo),
                        ColorOpt.red: segmentColorWidget(Colors.red[700]!),
                        ColorOpt.green: segmentColorWidget(Colors.green),
                        ColorOpt.orange: segmentColorWidget(Colors.orange),
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              settingTitle('선공'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<SettingController>(
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
              ),
              const Spacer(),
              SimpleButton(
                title: '게임 시작',
                width: 280,
                height: 60,
                color: Colors.indigo[800],
                onPressed: () => Get.to(
                  () => GameScreen(
                    settings: controller.getSettings(),
                  ),
                  binding: BindingsBuilder(() {
                    Get.put(GameController(controller.getSettings()));
                  }),
                  transition: Transition.zoom,
                  duration: const Duration(milliseconds: 500),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget settingTitle(String title) {
  return Text(
    title,
    style: AppStyle.settingTitleStyle,
  );
}
