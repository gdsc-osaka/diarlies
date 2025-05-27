import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';

enum AppIconType { appIcon, splash }

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, this.size = 48, this.type = AppIconType.appIcon});

  final double size;
  final AppIconType type;

  @override
  Widget build(BuildContext context) {
    final brightness = Styles.of(context).brightness;

    return Image.asset(
      switch (type) {
        AppIconType.appIcon => 'assets/images/app_icon.png',
        AppIconType.splash => switch (brightness) {
          Brightness.light => 'assets/images/splash_icon.png',
          Brightness.dark => 'assets/images/splash_icon_invert.png',
        },
      },
      width: size,
      height: size,
    );
  }
}
