import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/utils/alert_dialog.dart';
import 'package:tic_tac_toe_app/screens/home_screen.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        onPressed: () => showAlertDialog(
          title: '이동',
          middleText: '홈으로 이동하시겠습니까?',
          onConfirm: () => Get.offAll(() => const HomeScreen()),
        ),
        icon: Icon(
          Icons.home,
          size: 35,
          color: Colors.teal[900],
        ),
      ),
    );
  }
}
