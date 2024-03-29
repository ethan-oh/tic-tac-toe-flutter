import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/constant/text_styles.dart';

class SimpleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? color;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final double? elevation;
  const SimpleButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.color,
      this.width,
      this.height,
      this.textStyle,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: color,
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Text(
            title,
            style: textStyle ?? buttonStyle,
          ),
        ),
      ),
    );
  }
}