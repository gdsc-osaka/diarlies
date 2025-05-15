import 'package:flutter/material.dart';

import '../styles/styles.dart';

class NBCard extends StatelessWidget {
  const NBCard({super.key, this.child, this.color, this.padding});

  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Container(
      decoration: BoxDecoration(
        color: color ?? styles.color.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [styles.shadow.medium],
        border: Border.all(
          color: styles.color.border,
          width: 6,
        ),
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }
}
