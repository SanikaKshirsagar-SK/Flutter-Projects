import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallet.borderColor, double radius = 8]) =>
      OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 3),
          borderRadius: BorderRadius.circular(radius));
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallet.backgroundColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppPallet.backgroundColor, centerTitle: true),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(25),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(AppPallet.gradient2),
        errorBorder: _border(AppPallet.errorColor)),
    chipTheme: const ChipThemeData(
        color: WidgetStatePropertyAll(AppPallet.backgroundColor),
        side: BorderSide.none),
  );
}
