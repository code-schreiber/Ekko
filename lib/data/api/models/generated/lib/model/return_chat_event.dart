//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReturnChatEvent {
  /// Returns a new [ReturnChatEvent] instance.
  ReturnChatEvent({
    required this.chatId,
    this.emotionFeatures,
    required this.id,
    this.messageText,
    this.metadata,
    this.relatedEventId,
    required this.role,
    required this.timestamp,
    required this.type,
  });

  /// Identifier for the Chat this event occurred in. Formatted as a UUID.
  String chatId;

  /// Stringified JSON containing the prosody model inference results.  EVI uses the prosody model to measure 48 expressions related to speech and vocal characteristics. These results contain a detailed emotional and tonal analysis of the audio. Scores typically range from 0 to 1, with higher values indicating a stronger confidence level in the measured attribute.
  String? emotionFeatures;

  /// Identifier for a Chat Event. Formatted as a UUID.
  String id;

  /// The text of the Chat Event. This field contains the message content for each event type listed in the `type` field.
  String? messageText;

  /// Stringified JSON with additional metadata about the chat event.
  String? metadata;

  /// Identifier for a related chat event. Currently only seen on ASSISTANT_PROSODY events, to point back to the ASSISTANT_MESSAGE that generated these prosody scores
  String? relatedEventId;

  ReturnChatEventRole role;

  /// Time at which the Chat Event occurred. Measured in seconds since the Unix epoch.
  int timestamp;

  ReturnChatEventType type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReturnChatEvent &&
          other.chatId == chatId &&
          other.emotionFeatures == emotionFeatures &&
          other.id == id &&
          other.messageText == messageText &&
          other.metadata == metadata &&
          other.relatedEventId == relatedEventId &&
          other.role == role &&
          other.timestamp == timestamp &&
          other.type == type;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (chatId.hashCode) +
      (emotionFeatures == null ? 0 : emotionFeatures!.hashCode) +
      (id.hashCode) +
      (messageText == null ? 0 : messageText!.hashCode) +
      (metadata == null ? 0 : metadata!.hashCode) +
      (relatedEventId == null ? 0 : relatedEventId!.hashCode) +
      (role.hashCode) +
      (timestamp.hashCode) +
      (type.hashCode);

  @override
  String toString() =>
      'ReturnChatEvent[chatId=$chatId, emotionFeatures=$emotionFeatures, id=$id, messageText=$messageText, metadata=$metadata, relatedEventId=$relatedEventId, role=$role, timestamp=$timestamp, type=$type]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'chat_id'] = this.chatId;
    if (this.emotionFeatures != null) {
      json[r'emotion_features'] = this.emotionFeatures;
    } else {
      json[r'emotion_features'] = null;
    }
    json[r'id'] = this.id;
    if (this.messageText != null) {
      json[r'message_text'] = this.messageText;
    } else {
      json[r'message_text'] = null;
    }
    if (this.metadata != null) {
      json[r'metadata'] = this.metadata;
    } else {
      json[r'metadata'] = null;
    }
    if (this.relatedEventId != null) {
      json[r'related_event_id'] = this.relatedEventId;
    } else {
      json[r'related_event_id'] = null;
    }
    json[r'role'] = this.role;
    json[r'timestamp'] = this.timestamp;
    json[r'type'] = this.type;
    return json;
  }

  /// Returns a new [ReturnChatEvent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReturnChatEvent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ReturnChatEvent[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ReturnChatEvent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReturnChatEvent(
        chatId: mapValueOfType<String>(json, r'chat_id')!,
        emotionFeatures: mapValueOfType<String>(json, r'emotion_features'),
        id: mapValueOfType<String>(json, r'id')!,
        messageText: mapValueOfType<String>(json, r'message_text'),
        metadata: mapValueOfType<String>(json, r'metadata'),
        relatedEventId: mapValueOfType<String>(json, r'related_event_id'),
        role: ReturnChatEventRole.fromJson(json[r'role'])!,
        timestamp: mapValueOfType<int>(json, r'timestamp')!,
        type: ReturnChatEventType.fromJson(json[r'type'])!,
      );
    }
    return null;
  }

  static List<ReturnChatEvent> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ReturnChatEvent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReturnChatEvent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReturnChatEvent> mapFromJson(dynamic json) {
    final map = <String, ReturnChatEvent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReturnChatEvent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReturnChatEvent-objects as value to a dart map
  static Map<String, List<ReturnChatEvent>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ReturnChatEvent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReturnChatEvent.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'chat_id',
    'id',
    'role',
    'timestamp',
    'type',
  };
}
