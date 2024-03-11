import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/%08common/button.dart';
import 'package:tic_tac_toe_app/%08common/font_style.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/view/home_screen.dart';

class MenuScreen extends GetView<GameController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => Visibility(
        visible: (controller.gameStatus != GameStatus.playing),
        child: Container(
          color: Colors.black54,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: GetBuilder<GameController>(
                    builder: (controller) => Text(
                          controller.resultMessage,
                          style: AppStyle.resultTextStyle,
                        )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SimpleButton(
                  onPressed: () => Get.defaultDialog(
                      title: "저장",
                      middleText: "게임 기록을 저장하시겠습니까?",
                      buttonColor: Colors.blue,
                      backgroundColor: Colors.white,
                      confirmTextColor: Colors.white,
                      textConfirm: "확인",
                      onConfirm: () async => controller
                          .saveRecord()
                          .then((value) => Get.offAll(const HomeScreen())),
                      textCancel: "취소",
                  ),
                  title: '기록하기',
                  color: Colors.transparent,
                  elevation: 0,
                ),
              ),
              SimpleButton(
                onPressed: () => controller.restart(),
                title: '재경기',
                color: Colors.transparent,
                elevation: 0,
              ),
              SimpleButton(
                onPressed: () => Get.offAll(const HomeScreen()),
                title: 'Home',
                color: Colors.transparent,
                elevation: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}