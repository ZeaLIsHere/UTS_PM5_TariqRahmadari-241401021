import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:uts_pm5/features/quiz/question_history.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('riwayat tersimpan per nama dan nama dinormalisasi', () async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
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
}
