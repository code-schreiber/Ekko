import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required List<Map<String, dynamic>> chatMessages,
    required Map<String, double> emotions,
    required String createdAt,
    required String priority,
    required String diga,
    required String whatWentWell,
    required String challenges,
  }) = _Session;

  factory Session.fromJson(Map<String, Object?> json) => _$SessionFromJson(json);
}

extension SessionX on Session {
  List<String> topEmotionNames(int count) {
    final sorted = emotions.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(count).map((e) => e.key).toList();
  }
}
