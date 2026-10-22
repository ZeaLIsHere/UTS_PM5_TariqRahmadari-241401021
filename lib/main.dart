import 'package:flutter/material.dart';

import 'core/app_layout.dart';
import 'core/app_theme.dart';
import 'features/home/home_page.dart';
import 'features/quiz/quiz_session_factory.dart';

void main() => runApp(const YokaiApp());

class YokaiApp extends StatefulWidget {
  const YokaiApp({super.key, this.sessionFactory});
  final QuizSessionFactory? sessionFactory;
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
    builder: (context, child) {
      final theme = Theme.of(context);
      return Theme(
        data: theme.copyWith(
          textTheme: AppLayout.scaleTextTheme(context, theme.textTheme),
        ),
        child: child ?? const SizedBox.shrink(),
      );
    },
    home: HomePage(
      sessionFactory: widget.sessionFactory,
      onToggleTheme: () => setState(() {
        final currentDark =
            mode == ThemeMode.dark ||
            (mode == ThemeMode.system &&
                WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                    Brightness.dark);
        mode = currentDark ? ThemeMode.light : ThemeMode.dark;
      }),
    ),
  );
}
