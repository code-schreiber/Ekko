import 'package:evi_example/data/api/models/generated/lib/api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReturnChatPagedEvents', () {
    test('should parse return_chat_paged_events correctly', () {});

    test('to throw error for empty JSON`', () async {
      expect(() => ReturnChatPagedEvents.fromJson("{}"), throwsAssertionError);
    });

    test('to do basic mapping of required keys', () async {
      final jsonString = '''
      {
        "chat_group_id": "770e8400-e29b-41d4-a716-446655440000",
        "events_page": [
          {
            "chat_id": "550e8400-e29b-41d4-a716",
            "emotion_features": "{\\"happiness\\": 0.5}",
            "id": "660e8400-e29b-41d4-a716-446655440000",
            "message_text": "Event 1",
            "role": "USER",
            "timestamp": 1672531200,
            "type": "USER_MESSAGE"
          }
        ],
        "id": "990e8400-e29b-41d4-a716-446655440000",
        "page_number": 0,
        "page_size": 10,
        "pagination_direction": "ASC",
        "start_timestamp": 1672531200,
        "status": "ACTIVE",
        "total_pages": 1
      }
      ''';

      final result = ReturnChatPagedEvents.fromJson(jsonString);

      expect(result, isNotNull);
      expect(result!.chatGroupId, "770e8400-e29b-41d4-a716-446655440000");
      expect(result.eventsPage[0].chatId, "550e8400-e29b-41d4-a716");
      expect(result.eventsPage[0].emotionFeatures, "{\"happiness\": 0.5}");
      expect(result.eventsPage[0].id, "660e8400-e29b-41d4-a716-446655440000");
      expect(result.eventsPage[0].messageText, "Event 1");
      expect(result.eventsPage[0].role, ReturnChatEventRole.USER);
      expect(result.eventsPage[0].timestamp, 1672531200);
      expect(result.eventsPage[0].type, ReturnChatEventType.USER_MESSAGE);
      expect(result.eventsPage.length, 1);
      expect(result.id, "990e8400-e29b-41d4-a716-446655440000");
      expect(result.pageNumber, 0);
      expect(result.pageSize, 10);
      expect(result.paginationDirection,
          ReturnChatPagedEventsPaginationDirection.ASC);
      expect(result.startTimestamp, 1672531200);
      expect(result.status, ReturnChatPagedEventsStatus.ACTIVE);
      expect(result.totalPages, 1);
    });
  });
}
