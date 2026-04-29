import 'package:evi_example/provider/chat_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatProvider Tests', () {
    group('filterMessages', () {
      test(
          'removes messages from the start until finding one less than 200 characters',
          () {
        final json = '''
          {
            "events_page": [
              {
                "role": "SYSTEM",
                "message_text": "this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is long",
                "emotion_features": null
              },
              {
                "role": "SYSTEM",
                "message_text": "this is less than 200 characters",
                "emotion_features": null
              }
            ]
          }
        ''';

        final result = ChatProvider.filterMessages(json);

        expect(result[0]['text'], "this is less than 200 characters");
        expect(result.length, 1);
      });

      test('handles null message_text gracefully', () {
        final json = '''
          {
            "events_page": [
              {
                "role": "SYSTEM",
                "message_text": null,
                "emotion_features": null
              },
              {
                "role": "USER",
                "message_text": null
              },
              {
                "role": "SYSTEM",
                "message_text": "this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is more than 200 characters long this is long",
                "emotion_features": null
              },
              {
                "role": "SYSTEM",
                "message_text": "this is less than 200 characters",
                "emotion_features": null
              }
            ]
          }
        ''';

        final result = ChatProvider.filterMessages(json);

        expect(result[0]["role"], "SYSTEM");
        expect(result[1]["role"], "USER");
        expect(result[2]["role"], "SYSTEM");
        expect(result[3]["role"], "SYSTEM");
        expect(result.length, 4);
      });

      test('handles empty events_page list', () {
        final jsonInput = '{"events_page": []}';

        final result = ChatProvider.filterMessages(jsonInput);

        expect(result, isEmpty);
      });

      test('no trimming when first message is USER', () {
        final jsonInput = '''
        {
          "events_page": [
            {"role": "USER", "message_text": "Hello!", "emotion_features": "{}"}
          ]
        }
        ''';

        final result = ChatProvider.filterMessages(jsonInput);

        expect(result.length, 1);
        expect(result.first['role'], 'USER');
      });

      test('stops trimming when non-USER message is short (<= 200 chars)', () {
        final jsonInput = '''
        {
          "events_page": [
            {"role": "ASSISTANT", "message_text": "${"a" * 250}",  "emotion_features": "{}"},
            {"role": "ASSISTANT", "message_text": "Short message", "emotion_features": "{}"},
            {"role": "USER",      "message_text": "User hello",    "emotion_features": "{}"}
          ]
        }
        ''';

        final result = ChatProvider.filterMessages(jsonInput);

        // It should stop at the "Short message" because it's <= 200 chars, even though it's not USER.
        expect(result[0]['text'], 'Short message');
        expect(result[1]['text'], 'User hello');
        expect(result.length, 2);
      });

      test('trims multiple long non-USER messages', () {
        final jsonInput = '''
        {
          "events_page": [
            {"role": "ASSISTANT", "message_text": "${"a" * 250}", "emotion_features": "{}"},
            {"role": "ASSISTANT", "message_text": "${"b" * 250}", "emotion_features": "{}"},
            {"role": "USER", "message_text": "User text", "emotion_features": "{}"}
          ]
        }
        ''';

        final result = ChatProvider.filterMessages(jsonInput);

        expect(result.length, 1);
        expect(result.first['role'], 'USER');
      });

      test('trims until specific condition is met in mixed sequence', () {
        final jsonInput = '''
        {
          "events_page": [
            {"role": "ASSISTANT", "message_text": "${"a" * 250}", "emotion_features": "{}"},
            {"role": "ASSISTANT", "message_text": "${"b" * 250}", "emotion_features": "{}"},
            {"role": "ASSISTANT", "message_text": "Short one", "emotion_features": "{}"},
            {"role": "USER", "message_text": "User text", "emotion_features": "{}"}
          ]
        }
        ''';

        final result = ChatProvider.filterMessages(jsonInput);

        expect(result.length, 2);
        expect(result.first['text'], 'Short one');
      });

      test('stops trimming if role changes to USER', () {
        final jsonInput = '''
        {
          "events_page": [
            {"role": "ASSISTANT", "message_text": "${"a" * 250}", "emotion_features": "{}"},
            {"role": "USER",      "message_text": "${"b" * 250}", "emotion_features": "{}"}
          ]
        }
        ''';

        final result = ChatProvider.filterMessages(jsonInput);

        // Even if the USER message is long, it should stop because role == 'USER'.
        expect(result.first['role'], 'USER');
        expect(result.length, 1);
      });

      test('handles malformed JSON input', () {
        final jsonInput = '{ invalid }';
        expect(() => ChatProvider.filterMessages(jsonInput),
            throwsA(isA<FormatException>()));
      });

      test('handles missing events_page key in JSON', () {
        final jsonInput = '{"not_events": []}';

        expect(() => ChatProvider.filterMessages(jsonInput),
            throwsNoSuchMethodError);
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
