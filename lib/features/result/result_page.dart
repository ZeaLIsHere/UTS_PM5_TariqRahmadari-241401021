import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../core/app_layout.dart';
import '../../features/quiz/question.dart';
import '../../features/quiz/quiz_session.dart';
import '../../widgets/brand_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/result_badge.dart';
import '../../widgets/animated_progress.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.session});
  final QuizSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gutter = AppLayout.gutter(context);
    final score = session.score;
    final percentage = (score / session.questions.length * 100).round();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppLayout.contentWidth(context),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(gutter, 24, gutter, 48),
              child: LayoutBuilder(
                builder: (context, box) {
                  final wide = AppLayout.useColumns(box);
                  final summary = Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? AppTheme.darkSurface
                          : AppTheme.blush,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: ResultBadge(height: wide ? 170 : 120)),
                        const SizedBox(height: 22),
                        Text(
                          'Petualangan selesai, ${session.name}!',
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          percentage >= 80
                              ? 'Luar biasa! Kamu ahli mitos Jepang.'
                              : percentage >= 50
                              ? 'Bagus! Terus jelajahi dunia yōkai.'
                              : 'Setiap legenda punya cerita baru untuk dipelajari.',
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          spacing: 12,
                          runSpacing: 2,
                          children: [
                            Text(
                              '$score / ${session.questions.length}',
                              style: theme.textTheme.displayLarge?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                '$percentage% benar',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        AnimatedProgress(
                          value: score / session.questions.length,
                          label: 'Jawaban benar',
                        ),
                        const SizedBox(height: 22),
                        PrimaryButton(
                          label: 'Main lagi',
                          icon: Icons.replay_rounded,
                          onPressed: () => Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          ),
                        ),
                      ],
                    ),
                  );
                  final review = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ulasan jawaban',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kenali cerita di balik setiap jawabanmu.',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 22),
                      for (var i = 0; i < session.questions.length; i++)
                        _ReviewCard(
                          number: i + 1,
                          question: session.questions[i],
                          answer: session.answers[i],
                        ),
                    ],
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BrandHeader(),
                      SizedBox(height: wide ? 48 : 30),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: box.maxWidth * .38, child: summary),
                            const SizedBox(width: 42),
                            Expanded(child: review),
                          ],
                        )
                      else ...[
                        summary,
                        const SizedBox(height: 40),
                        review,
                      ],
                    ],
                  );
                },
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
    final theme = Theme.of(context);
    final correct = answer == question.correctIndex;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(18),
      ),
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
              Expanded(
                child: Text(
                  'Soal $number  •  ${correct ? 'Benar' : 'Belum tepat'}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            question.prompt,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 12),
          Text(
            'Jawabanmu: ${answer == null ? 'Belum dijawab' : question.options[answer!]}',
            style: theme.textTheme.bodyMedium,
          ),
          if (!correct)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Jawaban benar: ${question.options[question.correctIndex]}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Divider(color: theme.dividerColor, height: 1),
          const SizedBox(height: 12),
          Text(question.explanation, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
