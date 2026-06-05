import 'package:evi_example/models/session.dart';
import 'package:evi_example/pages/sessions_page.dart';
import 'package:evi_example/repository/session_repository.dart';
import 'package:evi_example/service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class _TestSessionRepository extends ChangeNotifier
    implements SessionRepository {
  final List<Session> _sessions;

  _TestSessionRepository(this._sessions);

  @override
  List<Session> getSessions() => List.unmodifiable(_sessions);

  void addSession(Session session) {
    _sessions.add(session);
    notifyListeners();
  }

  void removeLast() {
    _sessions.removeLast();
    notifyListeners();
  }
}

Widget _buildTestApp({required List<Session> sessions}) {
  final repository = _TestSessionRepository(sessions);
  return MaterialApp(
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider<SessionRepository>.value(value: repository),
        Provider<SessionService>.value(value: const SessionService()),
      ],
      child: const SessionsPage(),
    ),
  );
}

Widget _buildTestAppWithRepo({required _TestSessionRepository repository}) {
  return MaterialApp(
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider<SessionRepository>.value(value: repository),
        Provider<SessionService>.value(value: const SessionService()),
      ],
      child: const SessionsPage(),
    ),
  );
}

void main() {
  setUp(() {
    Intl.defaultLocale = 'en_US';
  });

  group('SessionsPage', () {
    testWidgets('renders empty state', (tester) async {
      await tester.pumpWidget(_buildTestApp(sessions: []));
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

      await tester.pumpWidget(_buildTestApp(sessions: sessions));
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

      await tester.pumpWidget(_buildTestApp(sessions: sessions));
      await tester.pump();

      expect(find.text('Joy, Sadness, Anger'), findsOneWidget);
    });

    testWidgets('shows session number and time', (tester) async {
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

      await tester.pumpWidget(_buildTestApp(sessions: sessions));
      await tester.pump();

      expect(find.textContaining('Session 1'), findsOneWidget);
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

      await tester.pumpWidget(_buildTestApp(sessions: sessions));
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

      await tester.pumpWidget(_buildTestApp(sessions: sessions));
      await tester.pump();

      final sessionTitles =
          find.textContaining('Session').evaluate().map((e) {
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

      await tester.pumpWidget(_buildTestApp(sessions: sessions));
      await tester.pump();

      expect(find.text('Thu, Nov 28'), findsOneWidget);
      expect(find.text('Fri, Nov 29'), findsOneWidget);
      expect(find.text('Sun, Dec 1'), findsOneWidget);
    });

    testWidgets('rebuilds when repository notifies listeners',
        (tester) async {
      final repository = _TestSessionRepository([
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

      await tester.pumpWidget(_buildTestAppWithRepo(repository: repository));
      await tester.pump();

      expect(find.textContaining('Session 1'), findsOneWidget);

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

      expect(find.textContaining('Session 2'), findsOneWidget);

      repository.removeLast();
      await tester.pump();

      expect(find.textContaining('Session 2'), findsNothing);
    });
  });
}
