import 'package:flutter/material.dart';

enum GridOpt {
  threeByThree(3),
  fourByFour(4),
  fiveByFive(5);

  const GridOpt(this.value);
  final int value;
}

enum AlignOpt {
  three(3),
  four(4),
  five(5);

  const AlignOpt(this.value);
  final int value;
  static AlignOpt fromInt(int value) {
    switch (value) {
      case 3:
        return AlignOpt.three;
      case 4:
        return AlignOpt.four;
      case 5:
        return AlignOpt.five;
      default:
        throw ArgumentError("Invalid value: $value");
    }
  }
}

enum MarkerOpt {
  circle(Icons.circle_outlined),
  cross(Icons.close),
  triangle(Icons.change_history),
  rectangle(Icons.square_outlined);

  const MarkerOpt(this.value);
  final IconData value;
}

enum ColorOpt {
  blue(Colors.indigo),
  red(Color(0xFFD32F2F)),
  green(Colors.green),
  orange(Colors.orange);

  const ColorOpt(this.value);
  final Color value;
}

enum TurnOpt { random, playerOne, playerTwo }

enum GameStatus { playing, playerOneWin, playerTwoWin, draw, pause, end }

const TextStyle buttonStyle = TextStyle(
    fontFamily: 'Jalnan2',
    // fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 25);

const TextStyle normalTextStyle = TextStyle(
    fontFamily: 'Jalnan2', fontWeight: FontWeight.normal, fontSize: 20);

const TextStyle smallTextStyle = TextStyle(
    fontFamily: 'Jalnan2', fontWeight: FontWeight.normal, fontSize: 17);

const TextStyle alertTextStyle = TextStyle(
    fontFamily: 'Jalnan2',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: Color.fromARGB(255, 156, 25, 16));

const TextStyle settingTitleStyle = TextStyle(
  // fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 17, 57, 19),
  fontSize: 22,
);

const TextStyle appBarTitleStyle = TextStyle(
  fontFamily: 'Jalnan2',
  color: Colors.black87,
  fontSize: 25,
);

const TextStyle resultTextStyle = TextStyle(
  decoration: TextDecoration.none, // scafold 안에 없기 때문에 스타일 안 준다.
  fontFamily: 'Jalnan2',
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 50,
);

const TextStyle dateTimeTextStyle = TextStyle(
  decoration: TextDecoration.none, // scafold 안에 없기 때문에 스타일 안 준다.
  color: Colors.black54,
  fontSize: 13,
);
