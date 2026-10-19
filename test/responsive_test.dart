import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/core/app_theme.dart';
import 'package:uts_pm5/features/quiz/quiz_page.dart';
import 'package:uts_pm5/features/quiz/quiz_session.dart';
import 'package:uts_pm5/features/result/result_page.dart';
import 'package:uts_pm5/features/home/home_page.dart';

void main() {
  for (final size in [
    const Size(320, 640),
    const Size(375, 812),
    const Size(768, 1024),
    const Size(844, 390),
    const Size(1024, 768),
    const Size(1440, 900),
  ]) {
    for (final dark in [false, true]) {
      for (final scale in [1.0, 2.0]) {
        testWidgets('halaman pada $size, dark=$dark, text=$scale', (
          tester,
        ) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1;
          addTearDown(() {
            tester.view.resetPhysicalSize();
            tester.view.resetDevicePixelRatio();
          });

          Widget frame(Widget child) => MaterialApp(
            theme: dark ? AppTheme.dark : AppTheme.light,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(scale)),
              child: child!,
            ),
            home: child,
          );
          await tester.pumpWidget(frame(HomePage(onToggleTheme: () {})));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);

          final session = QuizSession('Tariq Rahmadari dengan nama panjang')
            ..select(0);
          await tester.pumpWidget(
            frame(QuizPage(session: session, onFinish: () {})),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);

          await tester.pumpWidget(frame(ResultPage(session: session)));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          session.dispose();
        });
      }
    }
  }
}
