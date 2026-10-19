import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/features/quiz/question_history.dart';
import 'package:uts_pm5/features/quiz/quiz_session_factory.dart';

class _MemoryHistoryStore implements QuestionHistoryStore {
  final values = <String, QuestionHistory>{};

  @override
  Future<QuestionHistory> read(String playerName) async =>
      values[playerName] ??
      const QuestionHistory(usedIds: {}, lastSessionIds: {});

  @override
  Future<void> write(String playerName, QuestionHistory history) async {
    values[playerName] = history;
  }
}

void main() {
  test('riwayat tiap nama menghasilkan lima sesi unik', () async {
    final store = _MemoryHistoryStore();
    final factory = QuizSessionFactory(historyStore: store, random: Random(3));
    final seen = <String>{};
    for (var i = 0; i < 5; i++) {
      final session = await factory.create('Tariq');
      final ids = session.questions.map((question) => question.id).toSet();
      expect(ids, hasLength(10));
      expect(ids.intersection(seen), isEmpty);
      seen.addAll(ids);
      session.dispose();
    }
    expect(seen, hasLength(50));
    final previous = store.values['Tariq']!.lastSessionIds;
    final next = await factory.create('Tariq');
    expect(
      next.questions
          .map((question) => question.id)
          .toSet()
          .intersection(previous),
      isEmpty,
    );
    next.dispose();

    final other = await factory.create('Alya');
    expect(store.values['Alya']!.usedIds, hasLength(10));
    other.dispose();
  });
}
