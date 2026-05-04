import 'package:evi_example/data/api/models/generated/lib/api.dart';
import 'package:evi_example/provider/chat_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatProvider Tests', () {
    group('filterMessages', () {
      test(
          'removes messages from the start until finding one less than 200 characters',
          () {
        final body = '''
          {
            "chat_group_id": "",
            "events_page": [
              {
                "role": "SYSTEM",
                "message_text": "this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is long",
                "emotion_features": null,
                "chat_id": "",
                "id": "",
                "timestamp": 0,
                "type": "USER_MESSAGE"
              },
              {
                "role": "SYSTEM",
                "message_text": "this is less than 200 characters",
                "emotion_features": null,
                "chat_id": "",
                "id": "",
                "timestamp": 0,
                "type": "USER_MESSAGE"
              }
            ],
            "id": "",
            "page_number": 0,
            "page_size": 0,
            "pagination_direction": "ASC",
            "start_timestamp": 0,
            "status": "ACTIVE",
            "total_pages": 0
          }
        ''';

        final result = ChatProvider.filterMessages(body);

        expect(result[0]['text'], "this is less than 200 characters");
        expect(result.length, 1);
      });

      test('handles null message_text gracefully', () {
        final body = '''
          {
            "events_page": [
              {
                "role": "SYSTEM",
                "message_text": null,
                "emotion_features": null,
                "chat_id": "",
                "id": "",
                "timestamp": 0,
                "type": "USER_MESSAGE"
              },
              {
                "role": "USER",
                "message_text": null,
                "emotion_features": null,
                "chat_id": "",
                "id": "",
                "timestamp": 0,
                "type": "USER_MESSAGE"
              },
              {
                "role": "SYSTEM",
                "message_text": "this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is long",
                "emotion_features": null,
                "chat_id": "",
                "id": "",
                "timestamp": 0,
                "type": "USER_MESSAGE"
              },
              {
                "role": "SYSTEM",
                "message_text": "this is less than 200 characters",
                "emotion_features": null,
                "chat_id": "",
                "id": "",
                "timestamp": 0,
                "type": "USER_MESSAGE"
              }
            ],
            "chat_group_id": "",
            "id": "",
            "page_number": 0,
            "page_size": 0,
            "pagination_direction": "ASC",
            "start_timestamp": 0,
            "status": "ACTIVE",
            "total_pages": 0
          }
        ''';

        final result = ChatProvider.filterMessages(body);

        expect(result[0]["role"], ReturnChatEventRole.SYSTEM);
        expect(result[1]["role"], ReturnChatEventRole.USER);
        expect(result[2]["role"], ReturnChatEventRole.SYSTEM);
        expect(result[3]["role"], ReturnChatEventRole.SYSTEM);
        expect(result.length, 4);
      });

      test('handles empty events_page list', () {
        final body = '''
          {
            "chat_group_id": "",
            "events_page": [
            ],
            "id": "",
            "page_number": 0,
            "page_size": 0,
            "pagination_direction": "ASC",
            "start_timestamp": 0,
            "status": "ACTIVE",
            "total_pages": 0
          }
        ''';

        final result = ChatProvider.filterMessages(body);

        expect(result, isEmpty);
      });

      test('no trimming when first message is USER', () {
        final body = '''
          {
            "chat_group_id": "",
            "events_page": [
              {
                "role": "USER",
                "message_text": "Hello!",
                "emotion_features": "{}",
                "chat_id": "",
                "id": "",
                "timestamp": 0,
                "type": "USER_MESSAGE"
              }
            ],
            "id": "",
            "page_number": 0,
            "page_size": 0,
            "pagination_direction": "ASC",
            "start_timestamp": 0,
            "status": "ACTIVE",
            "total_pages": 0
          }
        ''';

        final result = ChatProvider.filterMessages(body);

        expect(result.length, 1);
        expect(result.first['role'], ReturnChatEventRole.USER);
      });

      test('stops trimming when non-USER message is short (<= 200 chars)', () {
        final body = '''
        {
          "events_page": [
            {
              "role": "SYSTEM",
              "message_text": "${"a" * 250}",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            },
            {
              "role": "SYSTEM",
              "message_text": "Short message",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            },
            {
              "role": "USER",
              "message_text": "User hello",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            }
          ],
          "chat_group_id": "",
          "id": "",
          "page_number": 0,
          "page_size": 0,
          "pagination_direction": "ASC",
          "start_timestamp": 0,
          "status": "ACTIVE",
          "total_pages": 0
        }
        ''';

        final result = ChatProvider.filterMessages(body);

        // It should stop at the "Short message" because it's <= 200 chars, even though it's not USER.
        expect(result, isNotEmpty);
        expect(result[0]['text'], 'Short message');
        expect(result[1]['text'], 'User hello');
        expect(result.length, 2);
      });

      test('trims multiple long non-USER messages', () {
        final body = '''
        {
          "events_page": [
            {
              "role": "SYSTEM",
              "message_text": "${"a" * 250}",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            },
            {
              "role": "SYSTEM",
              "message_text": "${"b" * 250}",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            },
            {
              "role": "USER",
              "message_text": "User text",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            }
          ],
          "chat_group_id": "",
          "id": "",
          "page_number": 0,
          "page_size": 0,
          "pagination_direction": "ASC",
          "start_timestamp": 0,
          "status": "ACTIVE",
          "total_pages": 0
        }
        ''';

        final result = ChatProvider.filterMessages(body);

        expect(result, isNotEmpty);
        expect(result.first['role'], ReturnChatEventRole.USER);
        expect(result.length, 1);
      });

      test('trims until specific condition is met in mixed sequence', () {
        final body = '''
        {
          "events_page": [
            {
              "role": "SYSTEM",
              "message_text": "${"a" * 250}",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            },
            {
              "role": "SYSTEM",
              "message_text": "${"b" * 250}",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            },
            {
              "role": "SYSTEM",
              "message_text": "Short one",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            },
            {
              "role": "USER",
              "message_text": "User text",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            }
          ],
          "chat_group_id": "",
          "id": "",
          "page_number": 0,
          "page_size": 0,
          "pagination_direction": "ASC",
          "start_timestamp": 0,
          "status": "ACTIVE",
          "total_pages": 0
        }
        ''';

        final result = ChatProvider.filterMessages(body);

        expect(result, isNotEmpty);
        expect(result.first['text'], 'Short one');
        expect(result.length, 2);
      });

      test('stops trimming if role changes to USER', () {
        final body = '''
        {
          "events_page": [
            {
              "role": "SYSTEM",
              "message_text": "${"a" * 250}",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            },
            {
              "role": "USER",
              "message_text": "${"b" * 250}",
              "emotion_features": "{}",
              "chat_id": "",
              "id": "",
              "timestamp": 0,
              "type": "USER_MESSAGE"
            }
          ],
          "chat_group_id": "",
          "id": "",
          "page_number": 0,
          "page_size": 0,
          "pagination_direction": "ASC",
          "start_timestamp": 0,
          "status": "ACTIVE",
          "total_pages": 0
        }
        ''';

        final result = ChatProvider.filterMessages(body);

        // Even if the USER message is long, it should stop because role == 'USER'.
        expect(result, isNotEmpty);
        expect(result.first['role'], ReturnChatEventRole.USER);
        expect(result.length, 1);
      });

      test('handles malformed JSON input', () {
        final body = '{ invalid }';
        expect(() => ChatProvider.filterMessages(body),
            throwsA(isA<FormatException>()));
      });

      test('throws error when missing events_page in JSON', () {
        final body = '{"not_events": []}';

        expect(() => ChatProvider.filterMessages(body), throwsAssertionError);
      });
    });

    group('processEmotions', () {
      test('calculates averages', () {
        final messages = [
          {'emotion_features': '{"Admiration": 0.4, "Adoration": 0.2}'},
          {
            'emotion_features':
                '{"Admiration": 0.2, "Adoration": 0.6, "Awkwardness": 1.0}'
          },
          {'emotion_features': null}
        ];

        final result = ChatProvider.processEmotions(messages);

        expect(result['Awkwardness'], 0.5);
        expect(result['Adoration'], 0.4);
        expect(result['Admiration'], (0.4 + 0.2) / 2);
      });

      test('sorts averages', () {
        final messages = [
          {'emotion_features': '{"Admiration": 0.4, "Adoration": 0.2}'},
          {
            'emotion_features':
                '{"Admiration": 0.2, "Adoration": 0.6, "Awkwardness": 1.0}'
          },
          {'emotion_features': null}
        ];

        final result = ChatProvider.processEmotions(messages);

        expect(result.keys.toString(), "(Awkwardness, Adoration, Admiration)");
        expect(result.values.toString(), "(0.5, 0.4, ${(0.4 + 0.2) / 2})");
      });

      test('ignores empty emotion_features', () {
        final messages = [
          {'emotion_features': '{"Admiration": 0.8}'},
          {'emotion_features': null}
        ];

        final result = ChatProvider.processEmotions(messages);

        expect(result['Admiration'], 0.8);
        expect(result.length, 1);
      });

      test('ignores empty emotion_features', () {
        final messages = [
          {'emotion_features': '{"Admiration": 0.8}'},
          {'emotion_features': '{}'}
        ];

        final result = ChatProvider.processEmotions(messages);

        final expected = <String, double>{};
        expected['Admiration'] = 0.4;
        expect(result, expected);
      });
    });
  });
}
