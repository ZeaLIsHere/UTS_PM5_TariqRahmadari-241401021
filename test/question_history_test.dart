import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:uts_pm5/features/quiz/question_history.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('riwayat tersimpan per nama dan nama dinormalisasi', () async {
    final store = LocalQuestionHistoryStore();
    await store.write(
      ' Tariq  Rahmadari ',
      const QuestionHistory(usedIds: {'q01', 'q02'}, lastSessionIds: {'q02'}),
    );

    final samePlayer = await LocalQuestionHistoryStore().read(
      'tariq rahmadari',
    );
    expect(samePlayer.usedIds, {'q01', 'q02'});
    expect(samePlayer.lastSessionIds, {'q02'});
    final otherPlayer = await store.read('Alya');
    expect(otherPlayer.usedIds, isEmpty);
  });

  test('riwayat rusak dianggap kosong tanpa melempar error', () async {
    final key =
        'yokai_question_history_v1_${base64Url.encode(utf8.encode('rusak'))}';
    await SharedPreferencesAsync().setString(key, 'bukan-json');

    final history = await LocalQuestionHistoryStore().read('Rusak');

    expect(history.usedIds, isEmpty);
    expect(history.lastSessionIds, isEmpty);
  });

  test('entri riwayat dengan tipe tidak dikenal diabaikan', () async {
    final key =
        'yokai_question_history_v1_${base64Url.encode(utf8.encode('lama'))}';
    await SharedPreferencesAsync().setString(
      key,
      jsonEncode({
        'used': ['q01', 7, null],
        'last': 'q02',
      }),
    );

    final history = await LocalQuestionHistoryStore().read('Lama');

    expect(history.usedIds, {'q01'});
    expect(history.lastSessionIds, isEmpty);
  });
}
