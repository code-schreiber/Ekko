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
  List<Session> getSessions() => _sessions;
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
  });
}
