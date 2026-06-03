import 'package:evi_example/provider/chat_provider.dart';
import 'package:evi_example/repository/session_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatProviderSessionRepository', () {
    late ChatProvider chatProvider;
    late ChatProviderSessionRepository repo;

    setUp(() {
      chatProvider = ChatProvider();
      chatProvider.previousChats.clear();
      repo = ChatProviderSessionRepository();
      repo.attach(chatProvider);
    });

    test('getSessions converts chat provider maps to Session models', () {
      chatProvider.previousChats.add(<String, dynamic>{
        'chatMessages': <Map<String, dynamic>>[
          <String, dynamic>{'role': 'USER', 'text': 'Hi', 'emotion_features': null},
        ],
        'emotions': <String, double>{'Joy': 0.9, 'Sadness': 0.1},
        'createdAt': '2024-12-01T10:00:00.000000',
        'priority': 'high',
        'diga': '',
        'whatWentWell': 'Good',
        'challenges': 'Time',
      });

      final sessions = repo.getSessions();

      expect(sessions.length, 1);
      final session = sessions.first;
      expect(session.createdAt, '2024-12-01T10:00:00.000000');
      expect(session.priority, 'high');
      expect(session.emotions['Joy'], 0.9);
      expect(session.whatWentWell, 'Good');
    });

    test('getSessions returns empty list when no chats exist', () {
      expect(repo.getSessions(), isEmpty);
    });

    test('handles null optional fields with defaults', () {
      chatProvider.previousChats.add(<String, dynamic>{
        'chatMessages': <Map<String, dynamic>>[],
        'emotions': <String, double>{},
        'createdAt': '2024-12-01T10:00:00.000000',
        'priority': 'medium',
      });

      final sessions = repo.getSessions();
      expect(sessions.length, 1);
      expect(sessions.first.diga, '');
      expect(sessions.first.whatWentWell, '');
      expect(sessions.first.challenges, '');
    });
  });
}
