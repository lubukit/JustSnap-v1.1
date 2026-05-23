import 'package:flutter/material.dart';

class AppColors {
  static const green = Color(0xFF05A832);
  static const deepGreen = Color(0xFF008F2A);
  static const lightGreen = Color(0xFF12C747);
  static const ink = Color(0xFF3F3F46);
  static const muted = Color(0xFF8F8F96);
  static const panel = Color(0xFFF3F3F3);
}

ThemeData buildJustSnapTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green,
      primary: AppColors.green,
      secondary: AppColors.deepGreen,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.panel,
    fontFamily: 'Arial',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
      headlineMedium: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
      titleLarge: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
      titleMedium: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
      bodyLarge: TextStyle(color: AppColors.ink, height: 1.35),
      bodyMedium: TextStyle(color: AppColors.ink, height: 1.35),
    ),
    useMaterial3: true,
  );
}
