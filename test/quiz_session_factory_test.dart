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

class _BrokenHistoryStore implements QuestionHistoryStore {
  _BrokenHistoryStore({required this.failRead, required this.failWrite});

  final bool failRead;
  final bool failWrite;
  int writes = 0;

  @override
  Future<QuestionHistory> read(String playerName) async {
    if (failRead) throw StateError('penyimpanan tidak tersedia');
    return const QuestionHistory(usedIds: {}, lastSessionIds: {});
  }

  @override
  Future<void> write(String playerName, QuestionHistory history) async {
    writes++;
    if (failWrite) throw StateError('penyimpanan penuh');
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

  test('kuis tetap dimulai saat riwayat gagal dibaca', () async {
    final store = _BrokenHistoryStore(failRead: true, failWrite: false);
    final factory = QuizSessionFactory(historyStore: store, random: Random(1));

    final session = await factory.create('Tariq');

    expect(session.questions, hasLength(10));
    expect(
      session.questions.map((question) => question.id).toSet(),
      hasLength(10),
    );
    session.dispose();
  });

  test('kuis tetap dimulai saat riwayat gagal disimpan', () async {
    final store = _BrokenHistoryStore(failRead: false, failWrite: true);
    final factory = QuizSessionFactory(historyStore: store, random: Random(2));

    final session = await factory.create('Tariq');

    expect(store.writes, 1);
    expect(session.questions, hasLength(10));
    expect(
      session.questions.map((question) => question.id).toSet(),
      hasLength(10),
    );
    session.dispose();
  });
}
