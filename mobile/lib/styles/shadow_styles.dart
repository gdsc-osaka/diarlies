import 'package:diarlies/styles/color_styles.dart';
import 'package:flutter/material.dart';

class ShadowStyles {
  const ShadowStyles({
    required this.low,
    required this.medium,
    required this.high,
  });

  final BoxShadow low;
  final BoxShadow medium;
  final BoxShadow high;

  static ShadowStyles from(ColorStyles color) {
    return ShadowStyles(
      low: BoxShadow(
        color: color.border,
        offset: const Offset(2, 4),
        blurRadius: 0,
        spreadRadius: 0,
      ),
      medium: BoxShadow(
        color: color.border,
        offset: const Offset(4, 8),
        blurRadius: 0,
        spreadRadius: 0,
      ),
      high: BoxShadow(
        color: color.border,
        offset: const Offset(6, 12),
        blurRadius: 0,
        spreadRadius: 0,
      ),
    );
  }
}