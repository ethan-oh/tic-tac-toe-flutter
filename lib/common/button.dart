import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_app/common/font_style.dart';
import 'package:tic_tac_toe_app/view/home/home_screen.dart';

class SimpleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? color;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final double? elevation;
  const SimpleButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.color,
      this.width,
      this.height,
      this.textStyle,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: color,
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Text(
            title,
            style: textStyle ?? AppStyle.buttonStyle,
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget HomeButton() {
  return IconButton(
      onPressed: () => Get.defaultDialog(
          title: "이동",
          middleText: "홈으로 이동하시겠습니까?",
          buttonColor: Colors.blue,
          backgroundColor: Colors.white,
          confirmTextColor: Colors.white,
          textConfirm: "확인",
          onConfirm: () => Get.offAll(()=> const HomeScreen()),
          textCancel: "취소",
          onCancel: () {}),
      icon: Icon(
        Icons.home,
        color: Colors.teal[900],
      ));
}
