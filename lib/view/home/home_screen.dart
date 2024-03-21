import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/animation_state.dart';
import 'package:tic_tac_toe_app/controller/records_controller.dart';
import 'package:tic_tac_toe_app/view/record/records_screen.dart';
import 'package:tic_tac_toe_app/view/setting/setting_screen.dart';
import 'package:tic_tac_toe_app/controller/setting_controller.dart';
import 'package:tic_tac_toe_app/common/error_snackbar.dart';
import 'package:tic_tac_toe_app/common/simple_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              logoImage(),
              Column(
                children: [
                  _startButton(),
                  _recordButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimationState logoImage() {
    return AnimationState(
      builder: (state) => AnimatedScale(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 1000),
        scale: state ? 1 : 0.95,
        child: Image.asset(
          'assets/images/game_logo.png',
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  SimpleButton _recordButton() {
    return SimpleButton(
      title: '기록 보기',
      width: 300,
      height: 70,
      color: Colors.teal[800],
      onPressed: () => (!kIsWeb)
          ? Get.to(
              () => const RecordsScreen(),
              binding: BindingsBuilder(
                () {
                  Get.put(
                    RecordsController(),
                  );
                },
              ),
            )
          : errorSnackBar(
              title: '경고',
              message: '모바일 앱에서만 사용 가능한 기능입니다.',
            ),
    );
  }

  SimpleButton _startButton() {
    return SimpleButton(
      title: '시작하기',
      width: 300,
      height: 70,
      color: Colors.indigo[800],
      onPressed: () => Get.to(
        () => const SettingScreen(),
        binding: BindingsBuilder(
          () {
            Get.put(SettingController());
          },
        ),
      ),
    );
  }
}
