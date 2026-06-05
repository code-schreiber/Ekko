import 'package:evi_example/models/session.dart';
import 'package:evi_example/pages/sessions_page.dart';
import 'package:evi_example/repository/session_repository.dart';
import 'package:evi_example/service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class TestSessionRepository extends ChangeNotifier
    implements SessionRepository {
  final List<Session> _sessions;

  TestSessionRepository(this._sessions);

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

Widget buildSessionPageApp({required List<Session> sessions}) {
  final repository = TestSessionRepository(sessions);
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

Widget buildSessionPageAppWithRepo(
    {required TestSessionRepository repository}) {
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

extension PumpSessionPage on WidgetTester {
  Future<void> pumpSessionPage(List<Session> sessions) {
    return pumpWidget(buildSessionPageApp(sessions: sessions));
  }
}
