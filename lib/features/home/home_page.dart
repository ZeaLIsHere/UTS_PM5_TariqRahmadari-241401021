import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/primary_button.dart';
import '../quiz/quiz_page.dart';
import '../quiz/quiz_session.dart';
import '../result/result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onToggleTheme});
  final VoidCallback onToggleTheme;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final name = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  void start() {
    if (form.currentState!.validate()) {
      final session = QuizSession(name.text.trim());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (quizContext) => QuizPage(
            session: session,
            onFinish: () => Navigator.push(
              quizContext,
              MaterialPageRoute(builder: (_) => ResultPage(session: session)),
            ),
          ),
        ),
      ).then((_) => session.dispose());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screen = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: (screen.width * .06).clamp(20.0, 48.0),
                vertical: 24,
              ),
              child: LayoutBuilder(
                builder: (context, box) {
                  final wide = box.maxWidth >= 700;
                  final intro = Form(
                    key: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '01 / PERJALANAN DIMULAI',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppTheme.coral,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Berani mengenal dunia yōkai?',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: wide ? 48 : 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Masuki dunia mitos Jepang lewat kuis singkat yang seru. Pilih jawabanmu dan lihat seberapa jauh pengetahuanmu.',
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Siapa namamu?',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: name,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => start(),
                          decoration: const InputDecoration(
                            hintText: 'Tulis namamu di sini',
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? 'Nama wajib diisi'
                              : null,
                        ),
                        const SizedBox(height: 18),
                        PrimaryButton(
                          label: 'Mulai petualangan',
                          onPressed: start,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '10 pertanyaan  •  ±5 menit  •  Tanpa pendaftaran',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                  final art = AspectRatio(
                    aspectRatio: wide ? 1 : 1.55,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFF3B273B)
                            : const Color(0xFFFBE1D8),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          FractionallySizedBox(
                            widthFactor: .64,
                            heightFactor: .76,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppTheme.coral.withValues(alpha: .15),
                                shape: BoxShape.circle,
                              ),
                              child: const FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Icon(
                                    Icons.temple_buddhist_rounded,
                                    color: AppTheme.coral,
                                    size: 220,
                                    semanticLabel: 'Ilustrasi kuil Jepang',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            top: 22,
                            right: 26,
                            child: Icon(
                              Icons.auto_awesome_rounded,
                              color: AppTheme.coral,
                              size: 30,
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 18,
                            child: Chip(
                              label: const Text('神話  •  MITOLOGI'),
                              backgroundColor: theme.colorScheme.surface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome_rounded,
                            color: AppTheme.coral,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'YŌKAI QUEST',
                            style: theme.textTheme.titleLarge?.copyWith(
                              letterSpacing: 1,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            tooltip: 'Ganti tema',
                            onPressed: widget.onToggleTheme,
                            icon: Icon(
                              theme.brightness == Brightness.dark
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: wide ? 64 : 28),
                      if (wide)
                        Row(
                          children: [
                            Expanded(child: intro),
                            const SizedBox(width: 52),
                            Expanded(child: art),
                          ],
                        )
                      else
                        Column(
                          children: [art, const SizedBox(height: 36), intro],
                        ),
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
