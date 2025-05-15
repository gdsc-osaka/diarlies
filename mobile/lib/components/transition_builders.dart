import 'package:flutter/material.dart';

class TransitionBuilders {
  static Widget fadeIn(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation.drive(CurveTween(curve: Curves.easeInOutCubic)), child: child);
  }
}
