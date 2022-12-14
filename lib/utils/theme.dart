import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color accentColor = Color(0xFF1FCCC2);
  static const Color bgColor = Color(0xFFEDEFF3);
  static const Color textColor = Color(0xFF3E5481);


  static ThemeData buildAppTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: accentColor,
      background: bgColor,
      onPrimary: textColor
    );

    return ThemeData.light()
        .copyWith(colorScheme: colorScheme);
  }
}