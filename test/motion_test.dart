import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/widgets/animated_progress.dart';
import 'package:uts_pm5/widgets/result_badge.dart';

void main() {
  testWidgets(
    'kurangi animasi langsung menampilkan progres dan lencana akhir',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: Scaffold(
              body: Column(
                children: [
                  AnimatedProgress(value: .8, label: 'Jawaban benar'),
                  ResultBadge(height: 120),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(
        tester
            .widget<LinearProgressIndicator>(
              find.byType(LinearProgressIndicator),
            )
            .value,
        .8,
      );
      final transform = tester.widget<Transform>(
        find
            .descendant(
              of: find.byType(ResultBadge),
              matching: find.byType(Transform),
            )
            .first,
      );
      expect(transform.transform.entry(0, 0), 1);
      expect(tester.binding.transientCallbackCount, 0);
    },
  );
}
