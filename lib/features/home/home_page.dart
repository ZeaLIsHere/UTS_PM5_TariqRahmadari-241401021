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
    final gutter = AppLayout.gutter(context);
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
                AppLayout.gap(context, 4.2, min: 22, max: 44),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final wide = AppLayout.useColumns(constraints);
                  final heroFontSize = wide
                      ? AppLayout.vw(context, 4, min: 34, max: 56)
                      : AppLayout.vw(context, 9.5, min: 30, max: 44);
                  final copy = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mitos Jepang, seberapa kenal kamu?',
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: heroFontSize,
                          letterSpacing: AppLayout.sp(context, -1),
                        ),
                      ),
                      SizedBox(
                        height: AppLayout.gap(
                          context,
                          2.1,
                          min: 12,
                          max: 22,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: AppLayout.vw(
                            context,
                            58,
                            min: 320,
                            max: 560,
                          ),
                        ),
                        child: Text(
                          'Dari rubah yang bisa berubah wujud hingga roh penghuni hutan. Ikuti perjalanan singkat dan temukan seberapa jauh kamu mengenal dunia yōkai.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(
                        height: AppLayout.gap(
                          context,
                          3.8,
                          min: 22,
                          max: 42,
                        ),
                      ),
                      Form(
                        key: form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Siapa namamu?',
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: AppLayout.gap(
                                context,
                                1.2,
                                min: 8,
                                max: 14,
                              ),
                            ),
                            TextFormField(
                              controller: name,
                              enabled: !isStarting,
                              autofillHints: const [AutofillHints.nickname],
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => start(),
                              decoration: InputDecoration(
                                labelText: 'Nama pemain',
                                hintText: 'Tulis namamu di sini',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: AppLayout.sp(
                                    context,
                                    20,
                                    min: 16,
                                    max: 26,
                                  ),
                                  vertical: AppLayout.gap(
                                    context,
                                    2.2,
                                    min: 14,
                                    max: 22,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  size: AppLayout.sp(
                                    context,
                                    22,
                                    min: 20,
                                    max: 27,
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'Nama wajib diisi'
                                  : null,
                            ),
                            SizedBox(
                              height: AppLayout.gap(
                                context,
                                1.7,
                                min: 11,
                                max: 19,
                              ),
                            ),
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
                    constraints: BoxConstraints(
                      maxHeight: AppLayout.vh(
                        context,
                        wide ? 50 : 30,
                        min: wide ? 280 : 170,
                        max: wide ? 480 : 300,
                      ),
                    ),
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
                                  width: AppLayout.sp(
                                    context,
                                    28,
                                    min: 24,
                                    max: 32,
                                  ),
                                  height: AppLayout.sp(
                                    context,
                                    28,
                                    min: 24,
                                    max: 32,
                                  ),
                                  excludeFromSemantics: true,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: AppLayout.gap(
                          context,
                          wide ? 5.6 : 3.8,
                          min: 22,
                          max: 56,
                        ),
                      ),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 11, child: copy),
                            SizedBox(
                              width: AppLayout.vw(
                                context,
                                4.8,
                                min: 28,
                                max: 56,
                              ),
                            ),
                            Expanded(flex: 10, child: artwork),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            copy,
                            SizedBox(
                              height: AppLayout.gap(
                                context,
                                3.8,
                                min: 20,
                                max: 42,
                              ),
                            ),
                            artwork,
                          ],
                        ),
                      SizedBox(
                        height: AppLayout.gap(
                          context,
                          6,
                          min: 34,
                          max: 62,
                        ),
                      ),
                      Divider(color: theme.dividerColor),
                      SizedBox(
                        height: AppLayout.gap(
                          context,
                          1.6,
                          min: 10,
                          max: 18,
                        ),
                      ),
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
