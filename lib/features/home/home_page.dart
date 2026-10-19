import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_theme.dart';
import '../../core/app_layout.dart';
import '../../widgets/brand_header.dart';
import '../../widgets/primary_button.dart';
import '../quiz/quiz_page.dart';
import '../quiz/quiz_session.dart';
import '../quiz/quiz_session_factory.dart';
import '../result/result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onToggleTheme, this.sessionFactory});
  final VoidCallback onToggleTheme;
  final QuizSessionFactory? sessionFactory;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final name = TextEditingController();
  final form = GlobalKey<FormState>();
  bool isStarting = false;

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  Future<void> start() async {
    if (isStarting) return;
    if (!form.currentState!.validate()) return;
    setState(() => isStarting = true);
    late final QuizSession session;
    try {
      session = await (widget.sessionFactory ?? QuizSessionFactory()).create(
        name.text.trim(),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Soal gagal disiapkan. Coba lagi.')),
      );
      setState(() => isStarting = false);
      return;
    }
    if (!mounted) {
      session.dispose();
      return;
    }
    setState(() => isStarting = false);
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
    final gutter = AppLayout.gutter(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppLayout.contentWidth(context),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(gutter, 24, gutter, 36),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final wide = AppLayout.useColumns(constraints);
                  final copy = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mitos Jepang, seberapa kenal kamu?',
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: wide
                              ? 52
                              : (width * .095).clamp(32.0, 44.0),
                          letterSpacing: -1,
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
                              enabled: !isStarting,
                              autofillHints: const [AutofillHints.nickname],
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => start(),
                              decoration: const InputDecoration(
                                labelText: 'Nama pemain',
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
                              isLoading: isStarting,
                              label: isStarting
                                  ? 'Menyiapkan soal...'
                                  : 'Mulai petualangan',
                              onPressed: isStarting ? null : start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  final artwork = ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: wide ? 480 : 280),
                    child: Semantics(
                      label: 'Ilustrasi kuil Jepang bersama maskot kitsune',
                      child: SvgPicture.asset(
                        'assets/svg/hero_card_artwork.svg',
                        fit: BoxFit.contain,
                        excludeFromSemantics: true,
                      ),
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
