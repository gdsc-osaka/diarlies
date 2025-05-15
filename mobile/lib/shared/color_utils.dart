import 'package:flutter/material.dart';

Color darkenColor(Color color, {double lightnessFactor = 0.1, double saturationFactor = 0.1}) {
  final hslColor = HSLColor.fromColor(color);
  final newLightness = (hslColor.lightness - lightnessFactor).clamp(0.0, 1.0);
  final newSaturation = (hslColor.saturation - saturationFactor).clamp(0.0, 1.0);
  return hslColor.withLightness(newLightness).withSaturation(newSaturation).toColor();
}
