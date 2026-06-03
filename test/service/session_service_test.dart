import 'package:evi_example/models/session.dart';
import 'package:evi_example/service/session_service.dart';
import 'package:flutter_test/flutter_test.dart';

Session _session(String createdAt, {Map<String, double>? emotions}) {
  return Session(
    chatMessages: [],
    emotions: emotions ?? {},
    createdAt: createdAt,
    priority: 'low',
    diga: '',
    whatWentWell: '',
    challenges: '',
  );
}

void main() {
  group('SessionService', () {
    late SessionService service;

    setUp(() {
      service = const SessionService();
    });

    test('groups sessions by date descending', () {
      final sessions = [
        _session('2024-12-02T10:00:00.000000'),
        _session('2024-12-01T10:00:00.000000'),
      ];
      final grouped = service.getGroupedSessions(sessions);
      expect(grouped.keys.elementAt(0),
          DateTime(2024, 12, 2));
      expect(grouped.keys.elementAt(1),
          DateTime(2024, 12, 1));
    });

    test('sorts sessions within same date group by time descending', () {
      final sessions = [
        _session('2024-12-01T14:00:00.000000'),
        _session('2024-12-01T10:00:00.000000'),
        _session('2024-12-01T18:00:00.000000'),
      ];
      final grouped = service.getGroupedSessions(sessions);
      final daySessions = grouped[DateTime(2024, 12, 1)]!;
      expect(daySessions[0].createdAt, '2024-12-01T18:00:00.000000');
      expect(daySessions[1].createdAt, '2024-12-01T14:00:00.000000');
      expect(daySessions[2].createdAt, '2024-12-01T10:00:00.000000');
    });

    test('returns empty map for empty list', () {
      final grouped = service.getGroupedSessions([]);
      expect(grouped, isEmpty);
    });

    test('handles single session', () {
      final sessions = [_session('2024-12-01T10:00:00.000000')];
      final grouped = service.getGroupedSessions(sessions);
      expect(grouped.length, 1);
      expect(grouped[DateTime(2024, 12, 1)]!.length, 1);
    });

    test('separates sessions on different days', () {
      final sessions = [
        _session('2024-12-01T10:00:00.000000'),
        _session('2024-12-02T10:00:00.000000'),
        _session('2024-12-01T14:00:00.000000'),
      ];
      final grouped = service.getGroupedSessions(sessions);
      expect(grouped.length, 2);
      expect(grouped[DateTime(2024, 12, 1)]!.length, 2);
      expect(grouped[DateTime(2024, 12, 2)]!.length, 1);
    });

    test('uses custom grouper when provided', () {
      final customService = SessionService.withGrouper((sessions) {
        return {DateTime(2024, 1, 1): sessions};
      });
      final sessions = [_session('2024-12-01T10:00:00.000000')];
      final grouped = customService.getGroupedSessions(sessions);
      expect(grouped.length, 1);
      expect(grouped.containsKey(DateTime(2024, 1, 1)), true);
    });
  });
}
