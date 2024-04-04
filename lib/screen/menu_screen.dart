import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/util/alert_dialog.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';
import 'package:tic_tac_toe_app/controller/game_controller.dart';
import 'package:tic_tac_toe_app/screen/home_screen.dart';
import 'package:tic_tac_toe_app/util/error_snackbar.dart';
import 'package:tic_tac_toe_app/widget/simple_button.dart';

class MenuScreen extends GetView<GameController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => Visibility(
        visible: controller.isMenuVisible,
        child: Container(
          color: Colors.black54,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              resultText(controller),
              const SizedBox(
                height: 60,
              ),
              _backButton(controller),
              _reStartButton(controller),
              _saveButton(controller),
              _homeButton(),
            ],
          ),
        ),
      ),
    );
  }

  SimpleButton _backButton(GameController controller) {
    return SimpleButton(
      title: controller.isGameFinish ? '결과 보기' : '돌아가기',
      color: Colors.transparent,
      elevation: 0,
      onPressed: () => controller.hideMenu(),
    );
  }

  SimpleButton _homeButton() {
    return SimpleButton(
      onPressed: () => Get.offAll(() => const HomeScreen()),
      title: 'Home',
      color: Colors.transparent,
      elevation: 0,
    );
  }

  SimpleButton _reStartButton(GameController controller) {
    return SimpleButton(
      onPressed: () => controller.restart(),
      title: '재경기',
      color: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _saveButton(GameController controller) {
    return Visibility(
      visible: controller.isGameFinish,
      child: SimpleButton(
        onPressed: () => (!kIsWeb)
              ? showAlertDialog(
                  title: '저장',
                  middleText: '게임 기록을 저장하시겠습니까?',
                  onConfirm: () async => controller.saveRecord().then(
                        (value) => Get.offAll(
                          () => const HomeScreen(),
                        ),
                      ),
                )
              : showErrorSnackBar(
                  title: '경고',
                  message: '모바일 앱에서만 사용 가능한 기능입니다.',
                ),
        title: '기록하기',
        color: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Text resultText(GameController controller) {
    return Text(
      controller.resultMessage,
      style: resultTextStyle,
    );
  }
}
