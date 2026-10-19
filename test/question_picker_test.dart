import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/features/quiz/question.dart';
import 'package:uts_pm5/features/quiz/question_picker.dart';

void main() {
  test('lima sesi pertama memakai 50 soal tanpa pengulangan', () {
    var used = <String>{};
    var last = <String>{};
    final allSeen = <String>{};
    for (var session = 0; session < 5; session++) {
      final selection = pickQuestions(
        bank: questionBank,
        usedIds: used,
        lastSessionIds: last,
        count: 10,
        random: Random(session),
      );
      final ids = selection.questions.map((question) => question.id).toSet();
      expect(ids, hasLength(10));
      expect(ids.intersection(allSeen), isEmpty);
      expect(selection.restartedCycle, isFalse);
      allSeen.addAll(ids);
      used = selection.usedIds;
      last = ids;
    }
    expect(allSeen, hasLength(50));
  });

  test('siklus baru tetap menghindari sesi terakhir', () {
    final last = questionBank.skip(40).map((question) => question.id).toSet();
    final selection = pickQuestions(
      bank: questionBank,
      usedIds: questionBank.map((question) => question.id).toSet(),
      lastSessionIds: last,
      count: 10,
      random: Random(7),
    );
    expect(selection.restartedCycle, isTrue);
    expect(
      selection.questions
          .map((question) => question.id)
          .toSet()
          .intersection(last),
      isEmpty,
    );
  });
}
