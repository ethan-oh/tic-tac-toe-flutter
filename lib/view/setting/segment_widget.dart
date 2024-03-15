import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget segmentWidget(String option, {double? width}) {
  return SizedBox(
    width: 90.w,
    height: 50.h,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          option,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget segmentIconWidget(IconData iconData, {Color? color}) {
  return SizedBox(
    width: 30.w,
    height: 50.h,
    child: Icon(
      iconData,
      size: 30,
      color: color,
    ),
  );
}

Widget segmentColorWidget(Color color) {
  return SizedBox(
    width: 30.w,
    height: 30.h,
    child: Icon(
      Icons.square,
      size: 20,
      color: color,
    ),
  );
}
