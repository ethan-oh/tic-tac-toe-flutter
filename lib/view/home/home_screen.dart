import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/%08common/button.dart';
import 'package:tic_tac_toe_app/controller/records_controller.dart';
import 'package:tic_tac_toe_app/view/record/records_screen.dart';
import 'package:tic_tac_toe_app/view/setting/setting_screen.dart';
import 'package:tic_tac_toe_app/controller/setting_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              logoImage(),
              const Spacer(),
              startButton(),
              recordButton(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  SimpleButton recordButton() {
    return SimpleButton(
      title: '기록 보기',
      width: 300,
      height: 70,
      color: Colors.teal[800],
      onPressed: () => Get.to(
        () => const RecordsScreen(),
        binding: BindingsBuilder(
          () {
            Get.put(
              RecordsController(),
            );
          },
        ),
      ),
    );
  }

  SimpleButton startButton() {
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

  Image logoImage() {
    return Image.asset(
      'assets/images/game_logo.png',
      width: 300,
      fit: BoxFit.cover,
    );
  }
}
