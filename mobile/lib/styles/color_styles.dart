import 'dart:ui';

import 'package:flutter/material.dart';

class ColorStyles {
  const ColorStyles({
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.error,
    required this.onError,
    required this.disabled,
    required this.onDisabled,
    required this.link,
    required this.border,
    required this.paper,
    required this.outline,
    required this.googleButton,
    required this.onGoogleButton,
    required this.appleButton,
    required this.onAppleButton,
    required this.greenPastel,
    required this.onGreenPastel,
    required this.greenHalfTone,
    required this.onGreenHalfTone,
    required this.green,
    required this.onGreen,
    required this.bluePastel,
    required this.onBluePastel,
    required this.blueHalfTone,
    required this.onBlueHalfTone,
    required this.blue,
    required this.onBlue,
    required this.orangePastel,
    required this.onOrangePastel,
    required this.orangeHalfTone,
    required this.onOrangeHalfTone,
    required this.orange,
    required this.onOrange,
    required this.redPastel,
    required this.onRedPastel,
    required this.redHalfTone,
    required this.onRedHalfTone,
    required this.red,
    required this.onRed,
    required this.purplePastel,
    required this.onPurplePastel,
    required this.purpleHalfTone,
    required this.onPurpleHalfTone,
    required this.purple,
    required this.onPurple,
    required this.pinkPastel,
    required this.onPinkPastel,
    required this.pinkHalfTone,
    required this.onPinkHalfTone,
    required this.pink,
    required this.onPink,
    required this.grey,
    required this.onGrey,
  });

  static ColorStyles from(Brightness brightness) {
    return switch (brightness) {
      Brightness.light => light,
      Brightness.dark => dark,
    };
  }

 
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color onTertiary;
  final Color error;
  final Color onError;
  final Color disabled;
  final Color onDisabled;
  final Color link;
  final Color border;
  final Color paper;
  final Color outline;

  final Color googleButton;
  final Color onGoogleButton;
  final Color appleButton;
  final Color onAppleButton;
 
  final Color greenPastel;
  final Color onGreenPastel;
  final Color greenHalfTone;
  final Color onGreenHalfTone;
  final Color green;
  final Color onGreen;

  final Color bluePastel;
  final Color onBluePastel;
  final Color blueHalfTone;
  final Color onBlueHalfTone;
  final Color blue;
  final Color onBlue;

  final Color orangePastel;
  final Color onOrangePastel;
  final Color orangeHalfTone;
  final Color onOrangeHalfTone;
  final Color orange;
  final Color onOrange;

  final Color redPastel;
  final Color onRedPastel;
  final Color redHalfTone;
  final Color onRedHalfTone;
  final Color red;
  final Color onRed;

  final Color purplePastel;
  final Color onPurplePastel;
  final Color purpleHalfTone;
  final Color onPurpleHalfTone;
  final Color purple;
  final Color onPurple;

  final Color pinkPastel;
  final Color onPinkPastel;
  final Color pinkHalfTone;
  final Color onPinkHalfTone;
  final Color pink;
  final Color onPink;

  final Color grey;
  final Color onGrey;

  static const light = ColorStyles(
    background: Color(0xFFDAF5F0),
    onBackground: Color(0xFF000000),
    surface: Color(0xFFFDFD96),
    onSurface: Color(0xFF000000),
    primary: Color(0xFFFF7A5C),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    tertiary: Color(0xFFF4F4F4),
    onTertiary: Color(0xFF000000),
    error: Color(0xFFFF6262),
    onError: Color(0xFFFFFFFF),
    disabled: Color(0xFFACACAC),
    onDisabled: Color(0xFF222222),
    link: Color(0xFF1C7AE6),
    border: Color(0xFF000000),
    paper: Color(0xFFFAEECD),
    outline: Color(0xFF292929),

    googleButton: Color(0xFFFFFFFF),
    onGoogleButton: Color(0xFF000000),
    appleButton: Color(0xFF3E3E3E),
    onAppleButton: Color(0xFFFFFFFF),

    greenPastel: Color(0xFFBAFCA2),
    onGreenPastel: Color(0xFF000000),
    greenHalfTone: Color(0xFF90EE90),
    onGreenHalfTone: Color(0xFF000000),
    green: Color(0xFF7FBC8C),
    onGreen: Color(0xFFFFFFFF),
    bluePastel: Color(0xFFDAF8F0),
    onBluePastel: Color(0xFF000000),
    blueHalfTone: Color(0xFF69D2E7),
    onBlueHalfTone: Color(0xFF000000),
    blue: Color(0xFF69D2E7),
    onBlue: Color(0xFFFFFFFF),
    orangePastel: Color(0xFFFDFD96),
    onOrangePastel: Color(0xFF000000),
    orangeHalfTone: Color(0xFFFFDB58),
    onOrangeHalfTone: Color(0xFF000000),
    orange: Color(0xFFE3A018),
    onOrange: Color(0xFFFFFFFF),
    redPastel: Color(0xFFF8D6B3),
    onRedPastel: Color(0xFF000000),
    redHalfTone: Color(0xFFFFA07A),
    onRedHalfTone: Color(0xFF000000),
    red: Color(0xFFFF6B6B),
    onRed: Color(0xFFFFFFFF),
    purplePastel: Color(0xFFE3DFF2),
    onPurplePastel: Color(0xFF000000),
    purpleHalfTone: Color(0xFFC4A1FF),
    onPurpleHalfTone: Color(0xFF000000),
    purple: Color(0xFF9723C9),
    onPurple: Color(0xFFFFFFFF),
    pinkPastel: Color(0xFFFFC0CA),
    onPinkPastel: Color(0xFF000000),
    pinkHalfTone: Color(0xFFFFB2EF),
    onPinkHalfTone: Color(0xFF000000),
    pink: Color(0xFFFF69B4),
    onPink: Color(0xFFFFFFFF),
    grey: Color(0xFFE3E3E3),
    onGrey: Color(0xFF000000),
  );

  static const dark = ColorStyles(
    background: Color(0xFF2D3332),
    onBackground: Color(0xFFF2F2F2),
    surface: Color(0xFF33331E),
    onSurface: Color(0xFFF2F2F2),
    primary: Color(0xFFF87959),
    onPrimary: Color(0xFF333333),
    secondary: Color(0xFF1C1C1C),
    onSecondary: Color(0xFFE6E6E6),
    tertiary: Color(0xFF333333),
    onTertiary: Color(0xFFD9D9D9),
    error: Color(0xFF4C1D1D),
    onError: Color(0xFF393939),
    disabled: Color(0xFF686868),
    onDisabled: Color(0xFFF1F1F1),
    link: Color(0xFF0A3B75),
    border: Color(0xFFFFFFFF),
    paper: Color(0xFF636259),
    outline: Color(0xFFE1E1E1),

    googleButton: Color(0xFFFFFFFF),
    onGoogleButton: Color(0xFF000000),
    appleButton: Color(0xFF3E3E3E),
    onAppleButton: Color(0xFFFFFFFF),

    greenPastel: Color(0xFFBAFCA2),
    onGreenPastel: Color(0xFF000000),
    greenHalfTone: Color(0xFF90EE90),
    onGreenHalfTone: Color(0xFF000000),
    green: Color(0xFF7FBC8C),
    onGreen: Color(0xFFFFFFFF),
    bluePastel: Color(0xFFDAF8F0),
    onBluePastel: Color(0xFF000000),
    blueHalfTone: Color(0xFF69D2E7),
    onBlueHalfTone: Color(0xFF000000),
    blue: Color(0xFF69D2E7),
    onBlue: Color(0xFFFFFFFF),
    orangePastel: Color(0xFFFDFD96),
    onOrangePastel: Color(0xFF000000),
    orangeHalfTone: Color(0xFFFFDB58),
    onOrangeHalfTone: Color(0xFF000000),
    orange: Color(0xFFE3A018),
    onOrange: Color(0xFFFFFFFF),
    redPastel: Color(0xFFF8D6B3),
    onRedPastel: Color(0xFF000000),
    redHalfTone: Color(0xFFFFA07A),
    onRedHalfTone: Color(0xFF000000),
    red: Color(0xFFFF6B6B),
    onRed: Color(0xFFFFFFFF),
    purplePastel: Color(0xFFE3DFF2),
    onPurplePastel: Color(0xFF000000),
    purpleHalfTone: Color(0xFFC4A1FF),
    onPurpleHalfTone: Color(0xFF000000),
    purple: Color(0xFF9723C9),
    onPurple: Color(0xFFFFFFFF),
    pinkPastel: Color(0xFFFFC0CA),
    onPinkPastel: Color(0xFF000000),
    pinkHalfTone: Color(0xFFFFB2EF),
    onPinkHalfTone: Color(0xFF000000),
    pink: Color(0xFFFF69B4),
    onPink: Color(0xFFFFFFFF),
    grey: Color(0xFFE3E3E3),
    onGrey: Color(0xFF000000),
  );
}
