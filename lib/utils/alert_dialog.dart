import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showAlertDialog(
    {required String title,
    required String middleText,
    required Function() onConfirm}) {
  return Get.defaultDialog(
      title: title,
      middleText: middleText,
      buttonColor: Colors.blue,
      backgroundColor: Colors.white,
      confirmTextColor: Colors.white,
      textConfirm: "확인",
      onConfirm: onConfirm,
      textCancel: "취소",
      onCancel: () {});
}
