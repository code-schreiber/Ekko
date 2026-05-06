// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ReturnChatEventType {
  @JsonValue('AGENT_MESSAGE')
  agentMessage('AGENT_MESSAGE'),
  @JsonValue('ASSISTANT_PROSODY')
  assistantProsody('ASSISTANT_PROSODY'),
  @JsonValue('CHAT_START_MESSAGE')
  chatStartMessage('CHAT_START_MESSAGE'),
  @JsonValue('CHAT_END_MESSAGE')
  chatEndMessage('CHAT_END_MESSAGE'),
  @JsonValue('FUNCTION_CALL')
  functionCall('FUNCTION_CALL'),
  @JsonValue('FUNCTION_CALL_RESPONSE')
  functionCallResponse('FUNCTION_CALL_RESPONSE'),
  @JsonValue('PAUSE_ONSET')
  pauseOnset('PAUSE_ONSET'),
  @JsonValue('RESUME_ONSET')
  resumeOnset('RESUME_ONSET'),
  @JsonValue('SESSION_SETTINGS')
  sessionSettings('SESSION_SETTINGS'),
  @JsonValue('SYSTEM_PROMPT')
  systemPrompt('SYSTEM_PROMPT'),
  @JsonValue('USER_INTERRUPTION')
  userInterruption('USER_INTERRUPTION'),
  @JsonValue('USER_MESSAGE')
  userMessage('USER_MESSAGE'),
  @JsonValue('USER_RECORDING_START_MESSAGE')
  userRecordingStartMessage('USER_RECORDING_START_MESSAGE'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ReturnChatEventType(this.json);

  factory ReturnChatEventType.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
