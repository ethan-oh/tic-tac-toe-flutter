import 'package:flutter/material.dart';

enum GridOpt {
  threeByThree(3),
  fourByFour(4),
  fiveByFive(5);

  const GridOpt(this.gridCount);
  final int gridCount;
}

enum AlignOpt {
  three(3),
  four(4),
  five(5);

  const AlignOpt(this.alignCount);
  final int alignCount;
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

  const MarkerOpt(this.marker);
  final IconData marker;
}

enum ColorOpt {
  blue(Colors.indigo),
  red(Color.fromRGBO(211, 47, 47, 1)),
  green(Colors.green),
  orange(Colors.orange);

  const ColorOpt(this.color);
  final Color color;
}

enum TurnOpt { random, playerOne, playerTwo }
