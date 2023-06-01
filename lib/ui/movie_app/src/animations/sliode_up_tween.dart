import 'package:flutter/material.dart';

class SlideUpTween extends StatelessWidget {
  const SlideUpTween(
      {super.key,
      required this.child,
      required this.begin,
       this.curve = Curves.easeOut,
       this.duration = const Duration(milliseconds: 750)});

  final Widget child; 
  final Offset begin;
  final Curve curve;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      duration: duration,
      tween: Tween( begin: begin, end: const Offset(0, 0) ),
      curve: curve,
      builder: (_, value, child) {
        return Transform.translate(offset: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
