import 'dart:math';

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
    final history = await _historyStore.read(playerName);
    final selection = pickQuestions(
      bank: questionBank,
      usedIds: history.usedIds,
      lastSessionIds: history.lastSessionIds,
      count: 10,
      random: _random,
    );
    await _historyStore.write(
      playerName,
      QuestionHistory(
        usedIds: selection.usedIds,
        lastSessionIds: selection.questions
            .map((question) => question.id)
            .toSet(),
      ),
    );
    return QuizSession(playerName.trim(), questions: selection.questions);
  }
}
