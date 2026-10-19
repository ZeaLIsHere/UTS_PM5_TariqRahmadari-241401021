import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/features/quiz/question.dart';

void main() {
  test('bank berisi 50 soal valid dengan identitas unik', () {
    expect(questionBank, hasLength(50));
    expect(questionBank.map((question) => question.id).toSet(), hasLength(50));
    expect(
      questionBank.map((question) => question.prompt).toSet(),
      hasLength(50),
    );
    for (final question in questionBank) {
      expect(question.id, isNotEmpty);
      expect(question.options, hasLength(4));
      expect(question.options.toSet(), hasLength(4));
      expect(question.correctIndex, inInclusiveRange(0, 3));
      expect(question.explanation, isNotEmpty);
    }
  });
}
