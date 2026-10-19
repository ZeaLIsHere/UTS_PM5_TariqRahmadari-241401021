import 'package:flutter/foundation.dart';

import 'question.dart';

class QuizSession extends ChangeNotifier {
  QuizSession(this.name, {List<QuizQuestion>? questions})
    : questions = List.unmodifiable(questions ?? defaultQuestions),
      answers = List<int?>.filled((questions ?? defaultQuestions).length, null);
  final String name;
  final List<QuizQuestion> questions;
  final List<int?> answers;
  int index = 0;

  int? get selected => answers[index];
  int get answered => answers.where((answer) => answer != null).length;
  int get score => List.generate(
    questions.length,
    (i) => answers[i] == questions[i].correctIndex ? 1 : 0,
  ).fold(0, (a, b) => a + b);

  void select(int option) {
    answers[index] = option;
    notifyListeners();
  }

  void goTo(int next) {
    if (next < 0 || next >= questions.length) return;
    index = next;
    notifyListeners();
  }
}
