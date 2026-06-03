import 'package:evi_example/models/session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Session', () {
    final session = Session(
      chatMessages: [
        {'role': 'USER', 'text': 'Hello', 'emotion_features': '{}'},
      ],
      emotions: {'Admiration': 0.5, 'Adoration': 0.3},
      createdAt: '2024-11-29T12:30:06.973870',
      priority: 'low',
      diga: '',
      whatWentWell: 'Great session',
      challenges: 'None',
    );

    test('JSON round-trip', () {
      final json = session.toJson();
      final restored = Session.fromJson(json);
      expect(restored, session);
    });

    test('topEmotionNames returns top N emotions sorted descending', () {
      final top2 = session.topEmotionNames(2);
      expect(top2, ['Admiration', 'Adoration']);
    });

    test('topEmotionNames returns fewer when count exceeds available', () {
      final top10 = session.topEmotionNames(10);
      expect(top10.length, 2);
    });

    test('topEmotionNames returns empty list for empty emotions', () {
      final empty = Session(
        chatMessages: [],
        emotions: {},
        createdAt: '2024-11-29T12:30:06.973870',
        priority: 'low',
        diga: '',
        whatWentWell: '',
        challenges: '',
      );
      expect(empty.topEmotionNames(3), isEmpty);
    });
  });
}
