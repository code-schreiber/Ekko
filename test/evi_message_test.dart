import 'package:flutter_test/flutter_test.dart';
import 'package:evi_example/evi_message.dart';

void main() {
  test('AssistantMessage with empty models has null prosody', () {
    final jsonString = '''
    {
      "type": "assistant_message",
      "message": {"role": "user", "content": "hello"},
      "models": {}
    }
    ''';

    final message = EviMessage.decode(jsonString) as AssistantMessage;

    expect(message.models.prosody, isNull);
  });

  test('AssistantMessage with prosody in models parses scores', () {
    var emotion1 = 'Admiration';
    var emotion1score = 0.00838470458984375;
    var emotion2 = 'Amusement';
    var emotion2score = 0.04827880859375;
    final jsonString = '''
    {
      "type": "assistant_message",
      "message": {"role": "user", "content": "hello"},
      "models": {
        "prosody": {
          "scores": {
            "$emotion1": $emotion1score,
            "$emotion2": $emotion2score
          }
        }
      }
    }
    ''';

    final msg = EviMessage.decode(jsonString) as AssistantMessage;

    expect(msg.models.prosody, isNotNull);
    expect(msg.models.prosody!.scores[emotion1], emotion1score);
    expect(msg.models.prosody!.scores[emotion2], emotion2score);
  });
}
