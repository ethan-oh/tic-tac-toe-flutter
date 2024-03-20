import 'package:flutter/material.dart';

Widget segmentWidget(String option, {double? width}) {
  return Container(
    width: double.maxFinite,
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          option,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget iconSegmentWidget(IconData iconData, {Color? color}) {
  return Container(
    width: double.maxFinite,
    padding: const EdgeInsets.symmetric(vertical: 5,),
    child: Icon(
      iconData,
      size: 30,
      color: color,
      
    ),
  );
}

Widget colorSegmentWidget(Color color) {
  return Container(
    width: double.maxFinite,
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Icon(
      Icons.rectangle,
      size: 25,
      color: color,
    ),
  );
}
