import 'dart:math';

import 'package:flutter/foundation.dart';

import 'question.dart';
import 'question_history.dart';
import 'question_picker.dart';
import 'quiz_session.dart';

class QuizSessionFactory {
  QuizSessionFactory({QuestionHistoryStore? historyStore, Random? random})
    : _historyStore = historyStore ?? LocalQuestionHistoryStore(),
      _random = random ?? Random();

  final QuestionHistoryStore _historyStore;
  final Random _random;

  Future<QuizSession> create(String playerName) async {
    var history = const QuestionHistory(usedIds: {}, lastSessionIds: {});
    try {
      history = await _historyStore.read(playerName);
    } catch (error) {
      // Riwayat hanya pengoptimalan; kuis tetap harus bisa dimulai.
      debugPrint('Gagal membaca riwayat soal: $error');
    }
    final knownIds = questionBank.map((question) => question.id).toSet();
    final selection = pickQuestions(
      bank: questionBank,
      usedIds: history.usedIds.intersection(knownIds),
      lastSessionIds: history.lastSessionIds.intersection(knownIds),
      count: 10,
      random: _random,
    );
    try {
      await _historyStore.write(
        playerName,
        QuestionHistory(
          usedIds: selection.usedIds,
          lastSessionIds: selection.questions
              .map((question) => question.id)
              .toSet(),
        ),
      );
    } catch (error) {
      // Gagal menyimpan riwayat tidak boleh membatalkan sesi yang sudah siap.
      debugPrint('Gagal menyimpan riwayat soal: $error');
    }
    return QuizSession(playerName.trim(), questions: selection.questions);
  }
}
