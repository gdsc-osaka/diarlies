import 'package:flutter/material.dart';

import '../_components/app_icon.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const path = '/';
  static const name = 'splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppIcon(size: 127, type: AppIconType.splash),
      ),
    );
  }
}
