import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/core/app_theme.dart';
import 'package:uts_pm5/features/quiz/quiz_page.dart';
import 'package:uts_pm5/features/quiz/quiz_session.dart';
import 'package:uts_pm5/features/result/result_page.dart';
import 'package:uts_pm5/main.dart';

void main() {
  for (final size in [const Size(375, 812), const Size(1440, 900)]) {
    testWidgets('semua halaman tidak overflow pada $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const YokaiApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      final session = QuizSession('Tariq')..select(0);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: QuizPage(session: session, onFinish: () {}),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: ResultPage(session: session),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      session.dispose();
    });
  }
}
