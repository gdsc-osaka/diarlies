import 'package:flutter/material.dart';

import '../styles/styles.dart';

class NBCard extends StatelessWidget {
  const NBCard({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Container(
      decoration: BoxDecoration(
        color: styles.color.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [styles.shadow.medium],
        border: Border.all(
          color: styles.color.border,
          width: 4,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: child,
    );
  }
}
