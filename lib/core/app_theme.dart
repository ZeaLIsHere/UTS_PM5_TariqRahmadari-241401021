import 'package:flutter/material.dart';

class AppTheme {
  static const coral = Color(0xFFE56C63);
  static ThemeData get light =>
      _make(Brightness.light, const Color(0xFFFFFAF4), const Color(0xFF402D45));
  static ThemeData get dark =>
      _make(Brightness.dark, const Color(0xFF18141D), const Color(0xFFF9EEF4));

  static ThemeData _make(Brightness brightness, Color background, Color ink) {
    final scheme = ColorScheme.fromSeed(
      seedColor: coral,
      brightness: brightness,
      primary: coral,
      onPrimary: Colors.white,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: background,
      colorScheme: scheme,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          height: 1.08,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
        headlineMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
        bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: ink),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }
}
