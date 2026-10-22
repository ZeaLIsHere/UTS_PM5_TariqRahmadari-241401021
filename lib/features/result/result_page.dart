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
              padding: EdgeInsets.fromLTRB(
                gutter,
                AppLayout.gap(context, 2.8, min: 14, max: 32),
                gutter,
                AppLayout.gap(context, 5.4, min: 28, max: 56),
              ),
              child: LayoutBuilder(
                builder: (context, box) {
                  final wide = AppLayout.useColumns(box);
                  final summary = Container(
                    padding: EdgeInsets.all(
                      AppLayout.sp(context, 28, min: 20, max: 36),
                    ),
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? AppTheme.darkSurface
                          : AppTheme.blush,
                      borderRadius: BorderRadius.circular(
                        AppLayout.sp(context, 26, min: 22, max: 32),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ResultBadge(
                            height: AppLayout.gap(
                              context,
                              wide ? 19 : 13.5,
                              min: wide ? 130 : 96,
                              max: wide ? 190 : 140,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.gap(
                            context,
                            2.6,
                            min: 14,
                            max: 28,
                          ),
                        ),
                        Text(
                          'Petualangan selesai, ${session.name}!',
                          style: theme.textTheme.headlineMedium,
                        ),
                        SizedBox(
                          height: AppLayout.gap(
                            context,
                            1.2,
                            min: 8,
                            max: 14,
                          ),
                        ),
                        Text(
                          percentage >= 80
                              ? 'Luar biasa! Kamu ahli mitos Jepang.'
                              : percentage >= 50
                              ? 'Bagus! Terus jelajahi dunia yōkai.'
                              : 'Setiap legenda punya cerita baru untuk dipelajari.',
                          style: theme.textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: AppLayout.gap(
                            context,
                            2.8,
                            min: 16,
                            max: 30,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          spacing: AppLayout.sp(context, 12, min: 9, max: 16),
                          runSpacing: 2,
                          children: [
                            Text(
                              '$score / ${session.questions.length}',
                              style: theme.textTheme.displayLarge?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: AppLayout.sp(context, 6, min: 4, max: 10),
                              ),
                              child: Text(
                                '$percentage% benar',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppLayout.gap(
                            context,
                            2.6,
                            min: 14,
                            max: 28,
                          ),
                        ),
                        AnimatedProgress(
                          value: score / session.questions.length,
                          label: 'Jawaban benar',
                        ),
                        SizedBox(
                          height: AppLayout.gap(
                            context,
                            2.6,
                            min: 14,
                            max: 28,
                          ),
                        ),
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
                      SizedBox(
                        height: AppLayout.gap(
                          context,
                          1,
                          min: 6,
                          max: 12,
                        ),
                      ),
                      Text(
                        'Kenali cerita di balik setiap jawabanmu.',
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: AppLayout.gap(
                          context,
                          2.6,
                          min: 14,
                          max: 28,
                        ),
                      ),
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
                      SizedBox(
                        height: AppLayout.gap(
                          context,
                          wide ? 5.6 : 3.6,
                          min: 22,
                          max: 56,
                        ),
                      ),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: box.maxWidth * .38,
                              child: summary,
                            ),
                            SizedBox(
                              width: AppLayout.vw(
                                context,
                                4.4,
                                min: 26,
                                max: 54,
                              ),
                            ),
                            Expanded(child: review),
                          ],
                        )
                      else ...[
                        summary,
                        SizedBox(
                          height: AppLayout.gap(
                            context,
                            4.8,
                            min: 28,
                            max: 48,
                          ),
                        ),
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
      margin: EdgeInsets.only(
        bottom: AppLayout.sp(context, 14, min: 10, max: 18),
      ),
      padding: EdgeInsets.all(
        AppLayout.sp(context, 20, min: 16, max: 26),
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(
          AppLayout.sp(context, 18, min: 16, max: 24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                correct ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: correct ? const Color(0xFF31966A) : AppTheme.coral,
                size: AppLayout.sp(context, 24, min: 22, max: 28),
              ),
              SizedBox(
                width: AppLayout.sp(context, 8, min: 6, max: 12),
              ),
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
          SizedBox(
            height: AppLayout.gap(
              context,
              1.4,
              min: 9,
              max: 16,
            ),
          ),
          Text(
            question.prompt,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: AppLayout.sp(context, 17, min: 16, max: 21),
            ),
          ),
          SizedBox(
            height: AppLayout.gap(
              context,
              1.4,
              min: 9,
              max: 16,
            ),
          ),
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
          SizedBox(
            height: AppLayout.gap(
              context,
              1.4,
              min: 9,
              max: 16,
            ),
          ),
          Divider(color: theme.dividerColor, height: 1),
          SizedBox(
            height: AppLayout.gap(
              context,
              1.4,
              min: 9,
              max: 16,
            ),
          ),
          Text(question.explanation, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
