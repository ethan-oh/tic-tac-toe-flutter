import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';

Widget segmentWidget(String option, {double? width}) {
  return Container(
    width: kIsWeb ? 200 : double.maxFinite,
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          option,
          style: segmentTextStyle,
        ),
      ],
    ),
  );
}

Widget iconSegmentWidget(IconData iconData, {Color? color}) {
  return Container(
    width: kIsWeb ? 200 * 3 / 4 : double.maxFinite,
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
    width: kIsWeb ? 200 * 3 / 4 : double.maxFinite,
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Icon(
      Icons.rectangle_rounded,
      size: 25,
      color: color,
    ),
  );
}
