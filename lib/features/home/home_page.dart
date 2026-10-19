import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_theme.dart';
import '../../widgets/brand_header.dart';
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
    if (!form.currentState!.validate()) return;
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final gutter = (width * .055).clamp(20.0, 52.0);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(gutter, 24, gutter, 36),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= 800;
                  final copy = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mitos Jepang, seberapa kenal kamu?',
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: wide ? 54 : (width < 380 ? 38 : 45),
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 530),
                        child: Text(
                          'Dari rubah yang bisa berubah wujud hingga roh penghuni hutan. Ikuti perjalanan singkat dan temukan seberapa jauh kamu mengenal dunia yōkai.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: const [
                          _InfoChip(
                            icon: Icons.help_outline_rounded,
                            label: '10 pertanyaan',
                          ),
                          _InfoChip(
                            icon: Icons.schedule_rounded,
                            label: '±5 menit',
                          ),
                          _InfoChip(
                            icon: Icons.auto_stories_rounded,
                            label: 'Pembahasan lengkap',
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Form(
                        key: form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            const SizedBox(height: 14),
                            PrimaryButton(
                              label: 'Mulai petualangan',
                              onPressed: start,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Gratis, tanpa pendaftaran. Jawabanmu tetap ada saat kamu berganti halaman.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  );
                  final artwork = Semantics(
                    label: 'Ilustrasi kuil Jepang bersama maskot kitsune',
                    child: SvgPicture.asset(
                      'assets/svg/hero_card_artwork.svg',
                      fit: BoxFit.contain,
                      excludeFromSemantics: true,
                    ),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BrandHeader(
                        trailing: IconButton(
                          tooltip: 'Ganti tema',
                          onPressed: widget.onToggleTheme,
                          icon: theme.brightness == Brightness.dark
                              ? const Icon(
                                  Icons.light_mode_rounded,
                                  color: AppTheme.coral,
                                )
                              : SvgPicture.asset(
                                  'assets/svg/icon_moon.svg',
                                  width: 28,
                                  height: 28,
                                  excludeFromSemantics: true,
                                ),
                        ),
                      ),
                      SizedBox(height: wide ? 48 : 32),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 11, child: copy),
                            const SizedBox(width: 46),
                            Expanded(flex: 10, child: artwork),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [copy, const SizedBox(height: 32), artwork],
                        ),
                      const SizedBox(height: 52),
                      Divider(color: theme.dividerColor),
                      const SizedBox(height: 14),
                      Text(
                        'Yōkai Quest  •  Jelajahi kisah, pilih jawaban, temukan ceritanya.',
                        style: theme.textTheme.bodyMedium,
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppTheme.coral),
          const SizedBox(width: 7),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
