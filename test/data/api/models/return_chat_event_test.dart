import 'package:evi_example/data/api/models/generated/lib/api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

void main() {
  group('ReturnChatEvent Tests', () {
    test('should parse a valid JSON string for return_chat_event', () {
      final jsonString = '''
      {
        "chat_id": "550e8400-e29b-41d4-a716-446655440000",
        "emotion_features": "{\\"happiness\\": 0.8, \\"sadness\\": 0.1}",
        "id": "660e8400-e29b-41d4-a716-446655440000",
        "message_text": "Hello world",
        "metadata": null,
        "related_event_id": null,
        "role": "USER",
        "timestamp": 1672531200,
        "type": "USER_MESSAGE"
      }
      ''';

      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      final event = ReturnChatEvent.fromJson(jsonMap);

      expect(event, isNotNull);
      expect(event!.chatId, '550e8400-e29b-41d4-a716-446655440000');
      expect(event.id, '660e8400-e29b-41d4-a716-446655440000');
      expect(event.role, ReturnChatEventRole.USER);
      expect(event.type, ReturnChatEventType.USER_MESSAGE);
      expect(event.messageText, 'Hello world');
      expect(event.timestamp, 1672531200);
      // Double-parsing check for emotion_features
      expect(event.emotionFeatures, isNotNull);
      final emotionMap = jsonDecode(event.emotionFeatures!);
      expect(emotionMap['happiness'], 0.8);
      expect(emotionMap['sadness'], 0.1);
    });

    test('should handle null emotion_features', () {
      final jsonString = '''
      {
        "chat_id": "550e8400-e29b-41d4-a716-446655440000",
        "emotion_features": null,
        "id": "660e8400-e29b-41d4-a716-446655440000",
        "message_text": "Hello world",
        "metadata": null,
        "related_event_id": null,
        "role": "USER",
        "timestamp": 1672531200,
        "type": "USER_MESSAGE"
      }
      ''';

      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      final event = ReturnChatEvent.fromJson(jsonMap);

      expect(event, isNotNull);
      expect(event!.emotionFeatures, isNull);
    });
  });
}
