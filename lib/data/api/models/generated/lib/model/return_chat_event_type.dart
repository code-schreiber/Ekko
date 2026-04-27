//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReturnChatEventType {
  /// Instantiate a new enum with the provided [value].
  const ReturnChatEventType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const AGENT_MESSAGE = ReturnChatEventType._(r'AGENT_MESSAGE');
  static const ASSISTANT_PROSODY = ReturnChatEventType._(r'ASSISTANT_PROSODY');
  static const CHAT_START_MESSAGE =
      ReturnChatEventType._(r'CHAT_START_MESSAGE');
  static const CHAT_END_MESSAGE = ReturnChatEventType._(r'CHAT_END_MESSAGE');
  static const FUNCTION_CALL = ReturnChatEventType._(r'FUNCTION_CALL');
  static const FUNCTION_CALL_RESPONSE =
      ReturnChatEventType._(r'FUNCTION_CALL_RESPONSE');
  static const PAUSE_ONSET = ReturnChatEventType._(r'PAUSE_ONSET');
  static const RESUME_ONSET = ReturnChatEventType._(r'RESUME_ONSET');
  static const SESSION_SETTINGS = ReturnChatEventType._(r'SESSION_SETTINGS');
  static const SYSTEM_PROMPT = ReturnChatEventType._(r'SYSTEM_PROMPT');
  static const USER_INTERRUPTION = ReturnChatEventType._(r'USER_INTERRUPTION');
  static const USER_MESSAGE = ReturnChatEventType._(r'USER_MESSAGE');
  static const USER_RECORDING_START_MESSAGE =
      ReturnChatEventType._(r'USER_RECORDING_START_MESSAGE');

  /// List of all possible values in this [enum][ReturnChatEventType].
  static const values = <ReturnChatEventType>[
    AGENT_MESSAGE,
    ASSISTANT_PROSODY,
    CHAT_START_MESSAGE,
    CHAT_END_MESSAGE,
    FUNCTION_CALL,
    FUNCTION_CALL_RESPONSE,
    PAUSE_ONSET,
    RESUME_ONSET,
    SESSION_SETTINGS,
    SYSTEM_PROMPT,
    USER_INTERRUPTION,
    USER_MESSAGE,
    USER_RECORDING_START_MESSAGE,
  ];

  static ReturnChatEventType? fromJson(dynamic value) =>
      ReturnChatEventTypeTypeTransformer().decode(value);

  static List<ReturnChatEventType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ReturnChatEventType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReturnChatEventType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReturnChatEventType] to String,
/// and [decode] dynamic data back to [ReturnChatEventType].
class ReturnChatEventTypeTypeTransformer {
  factory ReturnChatEventTypeTypeTransformer() =>
      _instance ??= const ReturnChatEventTypeTypeTransformer._();

  const ReturnChatEventTypeTypeTransformer._();

  String encode(ReturnChatEventType data) => data.value;

  /// Decodes a [dynamic value][data] to a ReturnChatEventType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReturnChatEventType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'AGENT_MESSAGE':
          return ReturnChatEventType.AGENT_MESSAGE;
        case r'ASSISTANT_PROSODY':
          return ReturnChatEventType.ASSISTANT_PROSODY;
        case r'CHAT_START_MESSAGE':
          return ReturnChatEventType.CHAT_START_MESSAGE;
        case r'CHAT_END_MESSAGE':
          return ReturnChatEventType.CHAT_END_MESSAGE;
        case r'FUNCTION_CALL':
          return ReturnChatEventType.FUNCTION_CALL;
        case r'FUNCTION_CALL_RESPONSE':
          return ReturnChatEventType.FUNCTION_CALL_RESPONSE;
        case r'PAUSE_ONSET':
          return ReturnChatEventType.PAUSE_ONSET;
        case r'RESUME_ONSET':
          return ReturnChatEventType.RESUME_ONSET;
        case r'SESSION_SETTINGS':
          return ReturnChatEventType.SESSION_SETTINGS;
        case r'SYSTEM_PROMPT':
          return ReturnChatEventType.SYSTEM_PROMPT;
        case r'USER_INTERRUPTION':
          return ReturnChatEventType.USER_INTERRUPTION;
        case r'USER_MESSAGE':
          return ReturnChatEventType.USER_MESSAGE;
        case r'USER_RECORDING_START_MESSAGE':
          return ReturnChatEventType.USER_RECORDING_START_MESSAGE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReturnChatEventTypeTypeTransformer] instance.
  static ReturnChatEventTypeTypeTransformer? _instance;
}
