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
