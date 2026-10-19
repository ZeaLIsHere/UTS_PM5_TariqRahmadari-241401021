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

  testWidgets('jawaban tetap terpilih setelah ukuran layar berubah', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const YokaiApp());
    await tester.ensureVisible(find.byType(TextFormField));
    await tester.enterText(find.byType(TextFormField), 'Tariq');
    await tester.ensureVisible(find.text('Mulai petualangan'));
    await tester.tap(find.text('Mulai petualangan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yōkai'));
    await tester.pump();
    tester.view.physicalSize = const Size(900, 600);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
