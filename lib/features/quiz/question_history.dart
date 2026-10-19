import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class QuestionHistory {
  const QuestionHistory({required this.usedIds, required this.lastSessionIds});

  final Set<String> usedIds;
  final Set<String> lastSessionIds;
}

abstract class QuestionHistoryStore {
  Future<QuestionHistory> read(String playerName);
  Future<void> write(String playerName, QuestionHistory history);
}

class LocalQuestionHistoryStore implements QuestionHistoryStore {
  LocalQuestionHistoryStore([SharedPreferencesAsync? preferences])
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  String _key(String playerName) {
    final normalized = playerName.trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    return 'yokai_question_history_v1_${base64Url.encode(utf8.encode(normalized))}';
  }

  @override
  Future<QuestionHistory> read(String playerName) async {
    final saved = await _preferences.getString(_key(playerName));
    if (saved == null) {
      return const QuestionHistory(usedIds: {}, lastSessionIds: {});
    }
    final data = jsonDecode(saved) as Map<String, dynamic>;
    return QuestionHistory(
      usedIds: (data['used'] as List<dynamic>).cast<String>().toSet(),
      lastSessionIds: (data['last'] as List<dynamic>).cast<String>().toSet(),
    );
  }

  @override
  Future<void> write(String playerName, QuestionHistory history) =>
      _preferences.setString(
        _key(playerName),
        jsonEncode({
          'used': history.usedIds.toList(),
          'last': history.lastSessionIds.toList(),
        }),
      );
}
