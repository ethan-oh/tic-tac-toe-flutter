import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/widgets/animation_state.dart';
import 'package:tic_tac_toe_app/controllers/records_controller.dart';
import 'package:tic_tac_toe_app/screens/records_screen.dart';
import 'package:tic_tac_toe_app/screens/setting_screen.dart';
import 'package:tic_tac_toe_app/controllers/setting_controller.dart';
import 'package:tic_tac_toe_app/utils/error_snackbar.dart';
import 'package:tic_tac_toe_app/widgets/simple_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _logoImage(),
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
        ),
      ),
    );
  }

  Widget _logoImage() {
    return Padding(
      padding: EdgeInsets.only(bottom: 100.h),
      child: AnimationState(
        builder: (state) => AnimatedScale(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 1000),
          scale: state ? 1 : 0.95,
          child: Image.asset(
            'assets/images/game_logo.png',
            // height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  SimpleButton _recordButton() {
    return SimpleButton(
      title: '기록 보기',
      height: 70,
      width: double.maxFinite,
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
          : showErrorSnackBar(
              title: '경고',
              message: '모바일 앱에서만 사용 가능한 기능입니다.',
            ),
    );
  }

  SimpleButton _startButton() {
    return SimpleButton(
      title: '시작하기',
      height: 70,
      width: double.maxFinite,
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
