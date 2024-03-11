import 'package:flutter/material.dart';

class AppStyle{

  static const TextStyle buttonStyle = TextStyle(
    fontFamily: 'Jalnan2',
    // fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 25
  );

  static const TextStyle normalTextStyle = TextStyle(
    fontFamily: 'Jalnan2',
    fontWeight: FontWeight.normal,
    fontSize: 20
  );

  static const TextStyle alertTextStyle = TextStyle(
    fontFamily: 'Jalnan2',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: Color.fromARGB(255, 156, 25, 16)
  );

  static const TextStyle settingTitleStyle = TextStyle(
    // fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 17, 57, 19),
    fontSize: 22,
  );

  static const TextStyle appBarTitleStyle = TextStyle(
    fontFamily: 'Jalnan2',
    color: Colors.black87,
    fontSize: 25,
  );

  static const TextStyle resultTextStyle = TextStyle(
    decoration: TextDecoration.none, // scafold 안에 없기 때문에 스타일 안 준다.
    fontFamily: 'Jalnan2',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 50,
  );


}