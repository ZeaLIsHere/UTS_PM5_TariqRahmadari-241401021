import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/features/quiz/quiz_session.dart';

void main() {
  test('jawaban tetap tersimpan saat berpindah soal', () {
    final session = QuizSession('Tariq');
    session.select(0);
    session.goTo(1);
    session.select(2);
    session.goTo(0);
    expect(session.selected, 0);
    expect(session.answered, 2);
    expect(session.score, 1);
    session.dispose();
  });
}
