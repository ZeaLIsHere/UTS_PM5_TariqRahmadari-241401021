import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../features/quiz/question.dart';
import '../../features/quiz/quiz_session.dart';
import '../../widgets/primary_button.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.session});
  final QuizSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final score = session.score;
    final percentage = (score / questions.length * 100).round();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.sizeOf(context).width * .06).clamp(
                  20.0,
                  48.0,
                ),
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppTheme.coral,
                      ),
                      const SizedBox(width: 8),
                      Text('YŌKAI QUEST', style: theme.textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.workspace_premium_rounded,
                          color: AppTheme.coral,
                          size: 58,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Petualangan selesai, ${session.name}!',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          percentage >= 80
                              ? 'Luar biasa! Kamu ahli mitos Jepang.'
                              : percentage >= 50
                              ? 'Bagus! Terus jelajahi dunia yōkai.'
                              : 'Setiap legenda punya cerita baru untuk dipelajari.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '$score / ${questions.length}',
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: AppTheme.coral,
                          ),
                        ),
                        Text(
                          '$percentage% jawaban benar',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text('Ulasan jawaban', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 6),
                  Text(
                    'Lihat kembali cerita di balik setiap pertanyaan.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 18),
                  for (var i = 0; i < questions.length; i++)
                    _ReviewCard(
                      number: i + 1,
                      question: questions[i],
                      answer: session.answers[i],
                    ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: 'Main lagi',
                    icon: Icons.replay_rounded,
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.number,
    required this.question,
    required this.answer,
  });
  final int number;
  final QuizQuestion question;
  final int? answer;

  @override
  Widget build(BuildContext context) {
    final correct = answer == question.correctIndex;
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  correct ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: correct ? const Color(0xFF31966A) : AppTheme.coral,
                ),
                const SizedBox(width: 8),
                Text(
                  'Soal $number • ${correct ? 'Benar' : 'Belum tepat'}',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              question.prompt,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Jawabanmu: ${answer == null ? 'Belum dijawab' : question.options[answer!]}',
            ),
            if (!correct)
              Text(
                'Jawaban benar: ${question.options[question.correctIndex]}',
                style: const TextStyle(
                  color: AppTheme.coral,
                  fontWeight: FontWeight.w700,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              question.explanation,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
