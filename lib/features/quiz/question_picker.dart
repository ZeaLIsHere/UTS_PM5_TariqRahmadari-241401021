import 'dart:math';

import 'question.dart';

class QuestionSelection {
  const QuestionSelection({
    required this.questions,
    required this.usedIds,
    required this.restartedCycle,
  });

  final List<QuizQuestion> questions;
  final Set<String> usedIds;
  final bool restartedCycle;
}

QuestionSelection pickQuestions({
  required List<QuizQuestion> bank,
  required Set<String> usedIds,
  required Set<String> lastSessionIds,
  required int count,
  required Random random,
}) {
  if (count < 1 || bank.length < count * 2) {
    throw ArgumentError('Bank soal harus memuat setidaknya dua sesi penuh.');
  }

  var candidates = bank
      .where((question) => !usedIds.contains(question.id))
      .toList();
  final restartedCycle = candidates.length < count;
  final currentHistory = restartedCycle ? {...lastSessionIds} : {...usedIds};
  if (restartedCycle) {
    candidates = bank
        .where((question) => !lastSessionIds.contains(question.id))
        .toList();
    if (candidates.length < count) {
      // Riwayat bisa saja tidak lengkap; jangan sampai sesi berisi kurang
      // dari jumlah soal yang diminta.
      candidates = [...bank];
    }
  }
  candidates.shuffle(random);
  final selected = List<QuizQuestion>.unmodifiable(candidates.take(count));
  currentHistory.addAll(selected.map((question) => question.id));

  return QuestionSelection(
    questions: selected,
    usedIds: currentHistory,
    restartedCycle: restartedCycle,
  );
}
