// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ReturnChatEventRole {
  @JsonValue('USER')
  user('USER'),
  @JsonValue('AGENT')
  agent('AGENT'),
  @JsonValue('SYSTEM')
  system('SYSTEM'),
  @JsonValue('TOOL')
  tool('TOOL'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ReturnChatEventRole(this.json);

  factory ReturnChatEventRole.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
