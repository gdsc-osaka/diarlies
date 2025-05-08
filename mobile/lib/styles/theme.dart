import 'package:diarlies/styles/color_styles.dart';
import 'package:flutter/material.dart';

ThemeData themeFromColorStyle(ColorStyles colorStyle) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colorStyle.primary,
      primary: colorStyle.primary,
      onPrimary: colorStyle.onPrimary,
      secondary: colorStyle.secondary,
      onSecondary: colorStyle.onSecondary,
      tertiary: colorStyle.tertiary,
      onTertiary: colorStyle.onTertiary,
      surface: colorStyle.background,
      onSurface: colorStyle.onBackground,
      error: colorStyle.error,
      onError: colorStyle.onError,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        shape: WidgetStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: colorStyle.border,
              width: 4.0,
            ),
          ),
        ),
      )
    ),
  );
}