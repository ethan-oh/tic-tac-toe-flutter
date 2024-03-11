import 'package:flutter/material.dart';

Widget segmentWidget(String option, {double? width}) {
  return SizedBox(
    width: 90,
    height: 50,
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
    width: 30,
    height: 50,
    child: Icon(
      iconData,
      size: 30,
      color: color,
    ),
  );
}

Widget segmentColorWidget(Color color) {
  return SizedBox(
    width: 30,
    height: 30,
    child: Icon(
      Icons.square,
      size: 20,
      color: color,
    ),
  );
}
