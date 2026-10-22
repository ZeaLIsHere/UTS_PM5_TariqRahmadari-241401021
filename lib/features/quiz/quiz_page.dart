import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_theme.dart';
import '../../core/app_layout.dart';
import '../../widgets/answer_tile.dart';
import '../../widgets/animated_progress.dart';
import '../../widgets/brand_header.dart';
import '../../widgets/primary_button.dart';
import 'quiz_session.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key, required this.session, required this.onFinish});
  final QuizSession session;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gutter = AppLayout.gutter(context);
    return AnimatedBuilder(
      animation: session,
      builder: (context, _) {
        final current = session.questions[session.index];
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
                    AppLayout.gap(context, 4.6, min: 24, max: 48),
                  ),
                  child: LayoutBuilder(
                    builder: (context, box) {
                      final wide = AppLayout.useColumns(box);
                      final progress = _QuizProgress(
                        session: session,
                        showArt: wide,
                      );
                      final questionArea = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            spacing: AppLayout.sp(context, 16, min: 10, max: 22),
                            runSpacing: AppLayout.sp(context, 8, min: 6, max: 12),
                            children: [
                              Text(
                                'PERTANYAAN ${session.index + 1}',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.4,
                                ),
                              ),
                              Text(
                                '${session.index + 1} / ${session.questions.length}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppLayout.gap(
                              context,
                              1.9,
                              min: 10,
                              max: 20,
                            ),
                          ),
                          Text(
                            current.prompt,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: AppLayout.sp(
                                context,
                                wide ? 34 : 26,
                                min: 23,
                                max: wide ? 38 : 32,
                              ),
                              height: 1.2,
                            ),
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
                            'Pilih satu jawaban yang paling tepat.',
                            style: theme.textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: AppLayout.gap(
                              context,
                              3.6,
                              min: 22,
                              max: 40,
                            ),
                          ),
                          for (var i = 0; i < current.options.length; i++)
                            AnswerTile(
                              label: String.fromCharCode(65 + i),
                              text: current.options[i],
                              selected: session.selected == i,
                              onTap: () => session.select(i),
                            ),
                          SizedBox(
                            height: AppLayout.gap(
                              context,
                              2.1,
                              min: 12,
                              max: 22,
                            ),
                          ),
                          PrimaryButton(
                            label: session.index == session.questions.length - 1
                                ? (session.answered == session.questions.length
                                      ? 'Lihat hasil'
                                      : 'Lengkapi jawaban')
                                : 'Pertanyaan berikutnya',
                            onPressed: session.selected == null
                                ? null
                                : () {
                                    if (session.index ==
                                        session.questions.length - 1) {
                                      if (session.answered ==
                                          session.questions.length) {
                                        onFinish();
                                      } else {
                                        session.goTo(
                                          session.answers.indexOf(null),
                                        );
                                      }
                                    } else {
                                      session.goTo(session.index + 1);
                                    }
                                  },
                          ),
                          if (session.index > 0)
                            Align(
                              alignment: Alignment.center,
                              child: TextButton.icon(
                                onPressed: () =>
                                    session.goTo(session.index - 1),
                                icon: const Icon(Icons.arrow_back_rounded),
                                label: const Text('Pertanyaan sebelumnya'),
                              ),
                            ),
                        ],
                      );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                tooltip: 'Kembali',
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back_rounded),
                              ),
                              SizedBox(
                                width: AppLayout.sp(
                                  context,
                                  8,
                                  min: 6,
                                  max: 12,
                                ),
                              ),
                              Expanded(child: BrandHeader()),
                            ],
                          ),
                          SizedBox(
                            height: AppLayout.gap(
                              context,
                              wide ? 6.2 : 2.8,
                              min: 18,
                              max: 58,
                            ),
                          ),
                          if (wide)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: box.maxWidth * .31,
                                  child: progress,
                                ),
                                SizedBox(
                                  width: AppLayout.vw(
                                    context,
                                    4.4,
                                    min: 26,
                                    max: 54,
                                  ),
                                ),
                                Expanded(child: questionArea),
                              ],
                            )
                          else ...[
                            progress,
                            SizedBox(
                              height: AppLayout.gap(
                                context,
                                3.8,
                                min: 20,
                                max: 42,
                              ),
                            ),
                            questionArea,
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
      },
    );
  }
}

class _QuizProgress extends StatelessWidget {
  const _QuizProgress({required this.session, required this.showArt});
  final QuizSession session;
  final bool showArt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(
        AppLayout.sp(context, showArt ? 26 : 18, min: 15, max: 32),
      ),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppTheme.darkSurface
            : AppTheme.blush,
        borderRadius: BorderRadius.circular(
          AppLayout.sp(context, 24, min: 20, max: 30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showArt) ...[
            Center(
              child: SvgPicture.asset(
                'assets/svg/quiz_scroll.svg',
                height: AppLayout.gap(
                  context,
                  20,
                  min: 140,
                  max: 220,
                ),
                semanticsLabel: 'Ilustrasi gulungan kuis',
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
          ],
          Text('Jejak petualanganmu', style: theme.textTheme.titleLarge),
          SizedBox(
            height: AppLayout.gap(
              context,
              .7,
              min: 5,
              max: 9,
            ),
          ),
          Text(
            '${session.answered} dari ${session.questions.length} soal sudah dijawab',
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(
            height: AppLayout.gap(
              context,
              2.1,
              min: 12,
              max: 22,
            ),
          ),
          AnimatedProgress(
            value: session.answered / session.questions.length,
            label: 'Progres jawaban',
          ),
          SizedBox(
            height: AppLayout.gap(
              context,
              2.1,
              min: 12,
              max: 22,
            ),
          ),
          Wrap(
            spacing: AppLayout.sp(context, 7, min: 5, max: 10),
            runSpacing: AppLayout.sp(context, 7, min: 5, max: 10),
            children: [
              for (var i = 0; i < session.questions.length; i++)
                Semantics(
                  selected: i == session.index,
                  label:
                      'Soal ${i + 1}, ${session.answers[i] == null ? 'belum dijawab' : 'sudah dijawab'}',
                  child: SizedBox(
                    width: AppLayout.sp(
                      context,
                      48,
                      min: 44,
                      max: 58,
                    ),
                    height: AppLayout.sp(
                      context,
                      48,
                      min: 44,
                      max: 58,
                    ),
                    child: OutlinedButton(
                      onPressed: () => session.goTo(i),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: session.answers[i] != null
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface,
                        backgroundColor: session.answers[i] != null
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surface,
                        side: BorderSide(
                          color: i == session.index
                              ? theme.colorScheme.onSurface
                              : theme.dividerColor,
                          width: i == session.index ? 2 : 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: ExcludeSemantics(child: Text('${i + 1}')),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
