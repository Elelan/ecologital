import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color accentColor = Color(0xFF1FCCC2);
  static const Color bgColor = Color(0xFFEDEFF3);
  static const Color textColor = Color(0xFF3E5481);

  static const moneyStyle = TextStyle(
      color: AppTheme.textColor,
      fontSize: 21,
      fontWeight: FontWeight.bold
  );

  static const titleStyle = TextStyle(
      color: AppTheme.textColor,
      fontSize: 18,
      fontWeight: FontWeight.bold
  );

  static const bodyStyle = TextStyle(
      color: AppTheme.textColor,
      fontSize: 16,
  );

  static const titleStyle2 = TextStyle(
      color: AppTheme.textColor,
      fontSize: 16,
  );

  static const subTextStyle = TextStyle(
      color: AppTheme.textColor,
      fontSize: 12,
  );

  static ThemeData buildAppTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
        primary: accentColor, background: bgColor, onPrimary: textColor);

    ThemeData myTheme = ThemeData.light();

    TextTheme defaultTextTheme = TextTheme(
        labelMedium: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: textColor));

    return myTheme.copyWith(
        textTheme: defaultTextTheme, colorScheme: colorScheme);
  }
}
