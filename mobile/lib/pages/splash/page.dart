import 'package:flutter/material.dart';

import '../_components/images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppIcon(size: 96),
      ),
    );
  }
}
