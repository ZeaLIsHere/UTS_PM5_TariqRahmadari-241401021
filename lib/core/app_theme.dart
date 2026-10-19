import 'package:flutter/material.dart';

class AppTheme {
  static const coral = Color(0xFFE56C63);
  static const plum = Color(0xFF402D45);
  static const cream = Color(0xFFFFFAF4);
  static const blush = Color(0xFFFBE1D8);
  static const paper = Color(0xFFFFFEFB);
  static const darkSurface = Color(0xFF29232E);
  static ThemeData get light => _make(Brightness.light, cream, plum);
  static ThemeData get dark =>
      _make(Brightness.dark, const Color(0xFF18141D), const Color(0xFFF9EEF4));

  static ThemeData _make(Brightness brightness, Color background, Color ink) {
    final scheme = ColorScheme.fromSeed(
      seedColor: coral,
      brightness: brightness,
      primary: brightness == Brightness.light ? const Color(0xFFA63D36) : coral,
      onPrimary: brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF25131D),
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: background,
      colorScheme: scheme,
      dividerColor: brightness == Brightness.light
          ? const Color(0xFFE8DAD8)
          : const Color(0xFF504653),
      cardColor: brightness == Brightness.light ? paper : darkSurface,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 52,
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
        fillColor: brightness == Brightness.light ? paper : darkSurface,
        hintStyle: TextStyle(color: ink.withValues(alpha: .75)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
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
