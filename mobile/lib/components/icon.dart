import 'package:flutter/material.dart';

import '../styles/styles.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key, this.size = 24});

  final double size;

  @override
  Widget build(BuildContext context) {

    return Image.asset(
      'assets/images/google_icon.png',
      width: size,
      height: size,
    );
  }
}

class AppleIcon extends StatelessWidget {
  const AppleIcon({super.key, this.size = 24});

  final double size;

  @override
  Widget build(BuildContext context) {
    final brightness = Styles.of(context).brightness;

  return Image.asset(
    switch (brightness) {
      Brightness.light => 'assets/images/apple_icon.png',
      Brightness.dark => 'assets/images/apple_icon_invert.png',
    },
    width: size,
    height: size,
  );
  }
}
