import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackBar({required String title, required String message} ) {
  Get.closeAllSnackbars();
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 1),
    icon: const Icon(
      Icons.warning,
      color: Colors.red,
      size: 30,
    ),
  );
}