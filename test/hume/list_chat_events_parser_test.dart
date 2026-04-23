import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:evi_example/hume/list_chat_events/models.dart';

void main() {
  group('ListChatEventsParser', () {
    test('parses a valid payload with one event', () {
      const String jsonStr = '''
      {
        "chat_group_id": "grp-1",
        "config": {"id": "cfg-1", "version": 2},
        "end_timestamp": null,
        "events_page": [
          {
            "chat_id": "chat-123",
            "emotion_features": "{\"some\":1}",
            "id": "ev-1",
            "message_text": "Hello",
            "metadata": "{\"a\":1}",
            "related_event_id": null,
            "role": "USER",
            "timestamp": 1700000000,
            "type": "USER_MESSAGE"
          }
        ],
        "id": "list-1",
        "metadata": null,
        "page_number": 0,
        "page_size": 3,
        "pagination_direction": "ASC",
        "start_timestamp": 1700000000,
        "status": "ACTIVE",
        "total_pages": 1
      }
      ''';

      final resp = ListChatEventsResponse.fromJson(jsonStr);

      expect(resp.chatGroupId, equals('grp-1'));
      expect(resp.config.id, equals('cfg-1'));
      expect(resp.config.version, equals(2));
      expect(resp.eventsPage.length, equals(1));
      final ev = resp.eventsPage.first;
      expect(ev.chatId, equals('chat-123'));
      expect(ev.id, equals('ev-1'));
      expect(ev.role, equals(ReturnChatEventRole.USER));
      expect(ev.type, equals(ReturnChatEventType.USER_MESSAGE));
      expect(ev.timestamp, equals(1700000000));
      expect(ev.messageText, equals('Hello'));
    });

    test('parses payload with optional fields omitted', () {
      const String jsonStr = '''
      {
        "chat_group_id": "grp-2",
        "config": {"id": "cfg-2"},
        "events_page": [
          {
            "chat_id": "chat-222",
            "id": "ev-2",
            "role": "AGENT",
            "timestamp": 1,
            "type": "AGENT_MESSAGE"
          }
        ],
        "id": "list-2",
        "page_number": 0,
        "page_size": 1,
        "pagination_direction": "ASC",
        "start_timestamp": 1,
        "status": "ACTIVE",
        "total_pages": 1
      }
      ''';

      final resp = ListChatEventsResponse.fromJson(jsonStr);
      expect(resp.endTimestamp, isNull);
      expect(resp.metadata, isNull);
      expect(resp.eventsPage.first.emotionFeatures, isNull);
      expect(resp.eventsPage.first.messageText, isNull);
      expect(resp.eventsPage.first.relatedEventId, isNull);
    });

    test('throws on malformed JSON', () {
      const String badJson = '{ not: valid json }';
      expect(() => ListChatEventsResponse.fromJson(badJson),
          throwsA(isA<FormatException>()));
    });

    test('parses nested config and event types', () {
      const String jsonStr = '''
      {
        "chat_group_id": "grp-3",
        "config": {"id": "cfg-3", "version": 5},
        "events_page": [
          {
            "chat_id": "chat-333",
            "id": "ev-3",
            "role": "SYSTEM",
            "timestamp": 1000,
            "type": "SYSTEM_PROMPT"
          }
        ],
        "id": "list-3",
        "page_number": 0,
        "page_size": 1,
        "pagination_direction": "DESC",
        "start_timestamp": 1000,
        "status": "ACTIVE",
        "total_pages": 1
      }
      ''';

      final resp = ListChatEventsResponse.fromJson(jsonStr);
      expect(resp.paginationDirection,
          equals(ReturnChatPagedEventsPaginationDirection.DESC));
      expect(resp.status, equals(ReturnChatPagedEventsStatus.ACTIVE));
      final e = resp.eventsPage.first;
      expect(e.role, equals(ReturnChatEventRole.SYSTEM));
      expect(e.type, equals(ReturnChatEventType.SYSTEM_PROMPT));
    });
  });
}
