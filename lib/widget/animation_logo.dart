import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/widget/animation_state.dart';

class AnimationLogo extends StatelessWidget {
  const AnimationLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationState(
      builder: (state) => AnimatedScale(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 1000),
        scale: state ? 1 : 0.95,
        child: Image.asset(
          'assets/images/game_logo.png',
          // height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
