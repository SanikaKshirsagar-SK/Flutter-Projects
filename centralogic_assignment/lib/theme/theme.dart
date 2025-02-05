import 'package:centralogic_assignment/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.whiteColor, centerTitle: true),
  );
}
