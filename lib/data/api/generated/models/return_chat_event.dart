// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'return_chat_event_role.dart';
import 'return_chat_event_type.dart';

part 'return_chat_event.g.dart';

/// A description of a single event in a chat returned from the server
@JsonSerializable()
class ReturnChatEvent {
  const ReturnChatEvent({
    required this.chatId,
    required this.emotionFeatures,
    required this.id,
    required this.messageText,
    required this.metadata,
    required this.relatedEventId,
    required this.role,
    required this.timestamp,
    required this.type,
  });
  
  factory ReturnChatEvent.fromJson(Map<String, Object?> json) => _$ReturnChatEventFromJson(json);
  
  /// Identifier for the Chat this event occurred in. Formatted as a UUID.
  @JsonKey(name: 'chat_id')
  final String chatId;

  /// Stringified JSON containing the prosody model inference results.
  ///
  /// EVI uses the prosody model to measure 48 expressions related to speech and vocal characteristics. These results contain a detailed emotional and tonal analysis of the audio. Scores typically range from 0 to 1, with higher values indicating a stronger confidence level in the measured attribute.
  @JsonKey(name: 'emotion_features')
  final String? emotionFeatures;

  /// Identifier for a Chat Event. Formatted as a UUID.
  final String id;

  /// The text of the Chat Event. This field contains the message content for each event type listed in the `type` field.
  @JsonKey(name: 'message_text')
  final String? messageText;

  /// Stringified JSON with additional metadata about the chat event.
  final String? metadata;

  /// Identifier for a related chat event. Currently only seen on ASSISTANT_PROSODY events, to point back to the ASSISTANT_MESSAGE that generated these prosody scores
  @JsonKey(name: 'related_event_id')
  final String? relatedEventId;
  final ReturnChatEventRole role;

  /// Time at which the Chat Event occurred. Measured in seconds since the Unix epoch.
  final int timestamp;
  final ReturnChatEventType type;

  Map<String, Object?> toJson() => _$ReturnChatEventToJson(this);
}
