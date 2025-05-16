import 'package:flutter/material.dart';

import '../styles/styles.dart';

class NBRefreshIndicator extends StatelessWidget {
  const NBRefreshIndicator({super.key, required this.onRefresh, required this.child});

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: styles.color.primary,
      backgroundColor: styles.color.surface,
      elevation: 0,
      child: child,
    );
  }
}
