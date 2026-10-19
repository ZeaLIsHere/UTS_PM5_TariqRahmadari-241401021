import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'features/home/home_page.dart';

void main() => runApp(const YokaiApp());

class YokaiApp extends StatefulWidget {
  const YokaiApp({super.key});
  @override
  State<YokaiApp> createState() => _YokaiAppState();
}

class _YokaiAppState extends State<YokaiApp> {
  ThemeMode mode = ThemeMode.system;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Yōkai Quest',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: mode,
    home: HomePage(
      onToggleTheme: () => setState(
        () => mode = mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
      ),
    ),
  );
}
