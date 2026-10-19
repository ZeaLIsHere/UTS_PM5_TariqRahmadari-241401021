import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/answer_tile.dart';
import '../../widgets/primary_button.dart';
import 'question.dart';
import 'quiz_session.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key, required this.session, required this.onFinish});
  final QuizSession session;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: session,
      builder: (context, _) {
        final current = questions[session.index];
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
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
                          IconButton(
                            tooltip: 'Kembali',
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_rounded),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'YŌKAI QUEST',
                              style: theme.textTheme.titleLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${session.index + 1}/${questions.length}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppTheme.coral,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      LinearProgressIndicator(
                        value: (session.index + 1) / questions.length,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(8),
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        color: AppTheme.coral,
                      ),
                      const SizedBox(height: 36),
                      Text(
                        'PERTANYAAN ${session.index + 1}',
                        style: theme.textTheme.labelLarge?.copyWith(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coral,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        current.prompt,
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Pilih satu jawaban yang menurutmu paling tepat.',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      for (var i = 0; i < current.options.length; i++)
                        AnswerTile(
                          label: String.fromCharCode(65 + i),
                          text: current.options[i],
                          selected: session.selected == i,
                          onTap: () => session.select(i),
                        ),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        label: session.index == questions.length - 1
                            ? 'Lihat hasil'
                            : 'Pertanyaan berikutnya',
                        onPressed: session.selected == null
                            ? null
                            : () {
                                if (session.index == questions.length - 1) {
                                  onFinish();
                                } else {
                                  session.goTo(session.index + 1);
                                }
                              },
                      ),
                      if (session.index > 0)
                        Center(
                          child: TextButton.icon(
                            onPressed: () => session.goTo(session.index - 1),
                            icon: const Icon(Icons.arrow_back_rounded),
                            label: const Text('Pertanyaan sebelumnya'),
                          ),
                        ),
                    ],
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
