import 'package:flutter/material.dart';

class OnboardingPositioned extends StatelessWidget {
  const OnboardingPositioned({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(left: 24, right: 24, top: 120, bottom: 80, child: child);
  }
}
