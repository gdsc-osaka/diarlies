import 'package:flutter/material.dart';

import '../styles/styles.dart';

class NBCard extends StatelessWidget {
  const NBCard({super.key, this.child, this.color, this.padding, this.shadow});

  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BoxShadow? shadow;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Container(
      decoration: BoxDecoration(
        color: color ?? styles.color.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [shadow ?? styles.shadow.medium],
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
