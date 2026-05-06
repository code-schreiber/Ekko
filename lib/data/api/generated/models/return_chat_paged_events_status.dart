// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ReturnChatPagedEventsStatus {
  @JsonValue('ACTIVE')
  active('ACTIVE'),
  @JsonValue('USER_ENDED')
  userEnded('USER_ENDED'),
  @JsonValue('USER_TIMEOUT')
  userTimeout('USER_TIMEOUT'),
  @JsonValue('MAX_DURATION_TIMEOUT')
  maxDurationTimeout('MAX_DURATION_TIMEOUT'),
  @JsonValue('INACTIVITY_TIMEOUT')
  inactivityTimeout('INACTIVITY_TIMEOUT'),
  @JsonValue('ERROR')
  error('ERROR'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ReturnChatPagedEventsStatus(this.json);

  factory ReturnChatPagedEventsStatus.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
