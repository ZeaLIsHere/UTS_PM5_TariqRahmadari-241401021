import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/features/quiz/quiz_session.dart';
import 'package:uts_pm5/features/result/result_page.dart';

void main() {
  testWidgets('hasil menampilkan nama dan skor sesi', (tester) async {
    final session = QuizSession('Tariq')..select(0);
    await tester.pumpWidget(MaterialApp(home: ResultPage(session: session)));
    expect(find.text('Petualangan selesai, Tariq!'), findsOneWidget);
    expect(find.text('1 / 10'), findsOneWidget);
    expect(find.text('Ulasan jawaban'), findsOneWidget);
    session.dispose();
  });
}
