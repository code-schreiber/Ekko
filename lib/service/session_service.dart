import 'package:evi_example/models/session.dart';

class SessionService {
  final Map<DateTime, List<Session>> Function(List<Session>) grouper;

  const SessionService()
      : grouper = _defaultGrouper;

  SessionService.withGrouper(this.grouper);

  static Map<DateTime, List<Session>> _defaultGrouper(List<Session> sessions) {
    final sorted = List<Session>.from(sessions)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final grouped = <DateTime, List<Session>>{};
    for (final session in sorted) {
      final date = DateTime.parse(session.createdAt);
      final day = DateTime(date.year, date.month, date.day);
      grouped.putIfAbsent(day, () => []).add(session);
    }
    return Map.fromEntries(
      grouped.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key)),
    );
  }

  Map<DateTime, List<Session>> getGroupedSessions(List<Session> sessions) {
    return grouper(sessions);
  }
}
