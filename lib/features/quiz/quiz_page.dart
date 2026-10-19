import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_theme.dart';
import '../../widgets/answer_tile.dart';
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
    final width = MediaQuery.sizeOf(context).width;
    final gutter = (width * .055).clamp(20.0, 52.0);
    return AnimatedBuilder(
      animation: session,
      builder: (context, _) {
        final current = session.questions[session.index];
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(gutter, 24, gutter, 40),
                  child: LayoutBuilder(
                    builder: (context, box) {
                      final wide = box.maxWidth >= 820;
                      final progress = _QuizProgress(
                        session: session,
                        showArt: wide,
                      );
                      final questionArea = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'PERTANYAAN ${session.index + 1}',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: AppTheme.coral,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.4,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${session.index + 1} / ${session.questions.length}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: AppTheme.coral,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            current.prompt,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: wide ? 37 : 29,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Pilih satu jawaban yang paling tepat.',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 30),
                          for (var i = 0; i < current.options.length; i++)
                            AnswerTile(
                              label: String.fromCharCode(65 + i),
                              text: current.options[i],
                              selected: session.selected == i,
                              onTap: () => session.select(i),
                            ),
                          const SizedBox(height: 18),
                          PrimaryButton(
                            label: session.index == session.questions.length - 1
                                ? 'Lihat hasil'
                                : 'Pertanyaan berikutnya',
                            onPressed: session.selected == null
                                ? null
                                : () {
                                    if (session.index ==
                                        session.questions.length - 1) {
                                      onFinish();
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
                              const SizedBox(width: 8),
                              Expanded(child: BrandHeader()),
                            ],
                          ),
                          SizedBox(height: wide ? 52 : 24),
                          if (wide)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: box.maxWidth * .31,
                                  child: progress,
                                ),
                                const SizedBox(width: 42),
                                Expanded(child: questionArea),
                              ],
                            )
                          else ...[
                            progress,
                            const SizedBox(height: 32),
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
      padding: EdgeInsets.all(showArt ? 26 : 18),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppTheme.darkSurface
            : AppTheme.blush,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showArt) ...[
            Center(
              child: SvgPicture.asset(
                'assets/svg/quiz_scroll.svg',
                height: 190,
                semanticsLabel: 'Ilustrasi gulungan kuis',
              ),
            ),
            const SizedBox(height: 22),
          ],
          Text('Jejak petualanganmu', style: theme.textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            '${session.answered} dari ${session.questions.length} soal sudah dijawab',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          LinearProgressIndicator(
            value: session.answered / session.questions.length,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.coral,
            backgroundColor: theme.colorScheme.surface,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              for (var i = 0; i < session.questions.length; i++)
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: session.answers[i] != null
                        ? AppTheme.coral
                        : theme.colorScheme.surface,
                    border: Border.all(
                      color: i == session.index
                          ? AppTheme.plum
                          : Colors.transparent,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: session.answers[i] != null
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
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
