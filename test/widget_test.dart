import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm5/main.dart';

void main() {
  testWidgets('nama wajib diisi sebelum mulai', (tester) async {
    await tester.pumpWidget(const YokaiApp());
    await tester.ensureVisible(find.text('Mulai petualangan'));
    await tester.tap(find.text('Mulai petualangan'));
    await tester.pump();
    expect(find.text('Nama wajib diisi'), findsOneWidget);
  });

  testWidgets('tema dapat diganti', (tester) async {
    await tester.pumpWidget(const YokaiApp());
    final before = tester
        .widget<MaterialApp>(find.byType(MaterialApp))
        .themeMode;
    await tester.tap(find.byTooltip('Ganti tema'));
    await tester.pump();
    final after = tester
        .widget<MaterialApp>(find.byType(MaterialApp))
        .themeMode;
    expect(after, isNot(before));
  });
}
