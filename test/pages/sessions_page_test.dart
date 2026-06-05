import 'package:evi_example/models/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import '../helpers/test_app.dart';

void main() {
  setUp(() {
    Intl.defaultLocale = 'en_US';
  });

  group('SessionsPage', () {
    testWidgets('renders empty state', (tester) async {
      await tester.pumpSessionPage([]);
      expect(find.text('Sessions'), findsOneWidget);
    });

    testWidgets('renders sessions grouped by date', (tester) async {
      final sessions = [
        Session(
          chatMessages: [],
          emotions: {'Joy': 0.9},
          createdAt: '2024-12-01T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
        Session(
          chatMessages: [],
          emotions: {'Sadness': 0.8},
          createdAt: '2024-12-02T10:00:00.000000',
          priority: 'high',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
      ];

      await tester.pumpSessionPage(sessions);
      await tester.pump();

      expect(find.text('Sun, Dec 1'), findsOneWidget);
      expect(find.text('Mon, Dec 2'), findsOneWidget);
    });

    testWidgets('shows top emotions as subtitle', (tester) async {
      final sessions = [
        Session(
          chatMessages: [],
          emotions: {'Joy': 0.9, 'Sadness': 0.5, 'Anger': 0.2},
          createdAt: '2024-12-01T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
      ];

      await tester.pumpSessionPage(sessions);
      await tester.pump();

      expect(find.text('Joy, Sadness, Anger'), findsOneWidget);
    });

    testWidgets('shows session number with exact time', (tester) async {
      final sessions = [
        Session(
          chatMessages: [],
          emotions: {},
          createdAt: '2024-12-01T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
      ];

      await tester.pumpSessionPage(sessions);
      await tester.pump();

      expect(find.textContaining('Session 1 at '), findsOneWidget);
      expect(find.textContaining('10:00'), findsOneWidget);
    });

    testWidgets('empty emotions renders with blank subtitle', (tester) async {
      final sessions = [
        Session(
          chatMessages: [],
          emotions: {},
          createdAt: '2024-12-01T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
      ];

      await tester.pumpSessionPage(sessions);
      await tester.pump();

      final subtitle = tester.widget<ListTile>(find.byType(ListTile)).subtitle;
      expect((subtitle as Text).data, isEmpty);
    });

    testWidgets('sessions on same date sorted by time descending',
        (tester) async {
      final sessions = [
        Session(
          chatMessages: [],
          emotions: {'Joy': 0.5},
          createdAt: '2024-12-01T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
        Session(
          chatMessages: [],
          emotions: {'Sadness': 0.8},
          createdAt: '2024-12-01T14:00:00.000000',
          priority: 'medium',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
        Session(
          chatMessages: [],
          emotions: {'Anger': 0.9},
          createdAt: '2024-12-01T18:00:00.000000',
          priority: 'high',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
      ];

      await tester.pumpSessionPage(sessions);
      await tester.pump();

      final sessionTitles =
          find.byWidgetPredicate((w) => w is Text && w.data!.startsWith('Session ')).evaluate().map((e) {
            return (e.widget as Text).data;
          }).toList();

      expect(sessionTitles[0], contains('18:00'));
      expect(sessionTitles[1], contains('14:00'));
      expect(sessionTitles[2], contains('10:00'));
    });

    testWidgets('renders sessions across multiple dates', (tester) async {
      final sessions = [
        Session(
          chatMessages: [],
          emotions: {'Joy': 0.5},
          createdAt: '2024-11-28T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
        Session(
          chatMessages: [],
          emotions: {'Sadness': 0.8},
          createdAt: '2024-11-29T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
        Session(
          chatMessages: [],
          emotions: {'Anger': 0.9},
          createdAt: '2024-12-01T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
      ];

      await tester.pumpSessionPage(sessions);
      await tester.pump();

      expect(find.text('Thu, Nov 28'), findsOneWidget);
      expect(find.text('Fri, Nov 29'), findsOneWidget);
      expect(find.text('Sun, Dec 1'), findsOneWidget);
    });

    testWidgets('rebuilds when repository notifies listeners',
        (tester) async {
      final repository = TestSessionRepository([
        Session(
          chatMessages: [],
          emotions: {'Joy': 0.5},
          createdAt: '2024-12-01T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
      ]);

      await tester.pumpWidget(
          buildSessionPageAppWithRepo(repository: repository));
      await tester.pump();

      expect(find.textContaining('Session 1 at '), findsOneWidget);

      repository.addSession(Session(
        chatMessages: [],
        emotions: {'Sadness': 0.8},
        createdAt: '2024-12-02T10:00:00.000000',
        priority: 'high',
        diga: '',
        whatWentWell: '',
        challenges: '',
      ));
      await tester.pump();

      expect(find.textContaining('Session 2 at '), findsOneWidget);

      repository.removeLast();
      await tester.pump();

      expect(find.textContaining('Session 2 at '), findsNothing);
    });

    testWidgets('session numbers are unique when preceding session exists',
        (tester) async {
      final sessions = [
        Session(
          chatMessages: [],
          emotions: {},
          createdAt: '2024-12-02T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
        Session(
          chatMessages: [],
          emotions: {},
          createdAt: '2024-12-01T10:00:00.000000',
          priority: 'low',
          diga: '',
          whatWentWell: '',
          challenges: '',
        ),
      ];

      await tester.pumpSessionPage(sessions);
      await tester.pump();

      expect(find.textContaining('Session 1 at '), findsOneWidget);
      expect(find.textContaining('Session 2 at '), findsOneWidget);
    });
  });
}
