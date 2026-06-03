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
