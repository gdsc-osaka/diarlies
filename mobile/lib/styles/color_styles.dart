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
    required this.onPink
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
    onDisabled: Color(0xFF000000),
    link: Color(0xFF1C7AE6),
    border: Color(0xFF000000),

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
    blue: Color(0xFF87CEEB),
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
  );

  static const dark = ColorStyles(
    background: Color(0xFF121212),
    onBackground: Color(0xFFE0E0E0),
    surface: Color(0xFF212121),
    onSurface: Color(0xFFE0E0E0),
    primary: Color(0xFFFFB59E),
    onPrimary: Color(0xFF000000),
    secondary: Color(0xFF4A4A4A),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF3A3A3A),
    onTertiary: Color(0xFFFFFFFF),
    error: Color(0xFFFFA8A8),
    onError: Color(0xFF373737),
    disabled: Color(0xFF606060),
    onDisabled: Color(0xFFFFFFFF),
    link: Color(0xFF549AE8),
    border: Color(0xFF505050),

    googleButton: Color(0xFF424242),
    onGoogleButton: Color(0xFFFFFFFF),
    appleButton: Color(0xFF424242),
    onAppleButton: Color(0xFFFFFFFF),

    greenPastel: Color(0xFF1A3A1A),
    onGreenPastel: Color(0xFFE0E0E0),
    greenHalfTone: Color(0xFF90EE90),
    onGreenHalfTone: Color(0xFF000000),
    green: Color(0xFF94DDA4),
    onGreen: Color(0xFF000000),

    bluePastel: Color(0xFF1A383F),
    onBluePastel: Color(0xFFE0E0E0),
    blueHalfTone: Color(0xFF69D2E7),
    onBlueHalfTone: Color(0xFF000000),
    blue: Color(0xFFA7DEF0),
    onBlue: Color(0xFF000000),

    orangePastel: Color(0xFF403C1A),
    onOrangePastel: Color(0xFFE0E0E0),
    orangeHalfTone: Color(0xFFFFDB58),
    onOrangeHalfTone: Color(0xFF000000),
    orange: Color(0xFFF0BE4B),
    onOrange: Color(0xFF000000),

    redPastel: Color(0xFF402D1A),
    onRedPastel: Color(0xFFE0E0E0),
    redHalfTone: Color(0xFFFFA07A),
    onRedHalfTone: Color(0xFF000000),
    red: Color(0xFFFF9494),
    onRed: Color(0xFF000000),

    purplePastel: Color(0xFF332D40),
    onPurplePastel: Color(0xFFE0E0E0),
    purpleHalfTone: Color(0xFFC4A1FF),
    onPurpleHalfTone: Color(0xFF000000),
    purple: Color(0xFFC067E2),
    onPurple: Color(0xFF000000),

    pinkPastel: Color(0xFF402D40),
    onPinkPastel: Color(0xFFE0E0E0),
    pinkHalfTone: Color(0xFFFFB2EF),
    onPinkHalfTone: Color(0xFF000000),
    pink: Color(0xFFFF94CF),
    onPink: Color(0xFF000000),
  );
}
