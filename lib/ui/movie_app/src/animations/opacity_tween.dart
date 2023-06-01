import 'package:flutter/material.dart';

class OpacityTween extends StatelessWidget {
  const OpacityTween(
      {super.key,
      required this.child,
      this.duration = const Duration(milliseconds: 700),
      this.curve = Curves.easeInToLinear,
       this.begin = 0.2});

  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: begin, end: 1.0),
      builder: (_, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
