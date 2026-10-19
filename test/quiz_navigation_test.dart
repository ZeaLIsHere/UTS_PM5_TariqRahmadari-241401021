import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/features/quiz/quiz_page.dart';
import 'package:uts_pm5/features/quiz/quiz_session.dart';

void main() {
  testWidgets('nomor soal bisa ditekan dan hasil menunggu semua jawaban', (
    tester,
  ) async {
    final session = QuizSession('Tariq')..select(0);
    var finished = false;
    await tester.pumpWidget(
      MaterialApp(
        home: QuizPage(session: session, onFinish: () => finished = true),
      ),
    );
    final last = find.widgetWithText(OutlinedButton, '10');
    await tester.ensureVisible(last);
    await tester.tap(last);
    await tester.pumpAndSettle();
    expect(session.index, 9);
    session.select(0);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Lengkapi jawaban'));
    await tester.tap(find.text('Lengkapi jawaban'));
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    expect(session.index, 1);
    expect(session.answers[0], 0);
    for (var i = 1; i < 9; i++) {
      session.goTo(i);
      session.select(0);
    }
    session.goTo(9);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Lihat hasil'));
    await tester.tap(find.text('Lihat hasil'));
    expect(finished, isTrue);
    await tester.pumpWidget(const SizedBox());
    session.dispose();
  });
}
