//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReturnChatPagedEventsStatus {
  /// Instantiate a new enum with the provided [value].
  const ReturnChatPagedEventsStatus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ACTIVE = ReturnChatPagedEventsStatus._(r'ACTIVE');
  static const USER_ENDED = ReturnChatPagedEventsStatus._(r'USER_ENDED');
  static const USER_TIMEOUT = ReturnChatPagedEventsStatus._(r'USER_TIMEOUT');
  static const MAX_DURATION_TIMEOUT =
      ReturnChatPagedEventsStatus._(r'MAX_DURATION_TIMEOUT');
  static const INACTIVITY_TIMEOUT =
      ReturnChatPagedEventsStatus._(r'INACTIVITY_TIMEOUT');
  static const ERROR = ReturnChatPagedEventsStatus._(r'ERROR');

  /// List of all possible values in this [enum][ReturnChatPagedEventsStatus].
  static const values = <ReturnChatPagedEventsStatus>[
    ACTIVE,
    USER_ENDED,
    USER_TIMEOUT,
    MAX_DURATION_TIMEOUT,
    INACTIVITY_TIMEOUT,
    ERROR,
  ];

  static ReturnChatPagedEventsStatus? fromJson(dynamic value) =>
      ReturnChatPagedEventsStatusTypeTransformer().decode(value);

  static List<ReturnChatPagedEventsStatus> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ReturnChatPagedEventsStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReturnChatPagedEventsStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReturnChatPagedEventsStatus] to String,
/// and [decode] dynamic data back to [ReturnChatPagedEventsStatus].
class ReturnChatPagedEventsStatusTypeTransformer {
  factory ReturnChatPagedEventsStatusTypeTransformer() =>
      _instance ??= const ReturnChatPagedEventsStatusTypeTransformer._();

  const ReturnChatPagedEventsStatusTypeTransformer._();

  String encode(ReturnChatPagedEventsStatus data) => data.value;

  /// Decodes a [dynamic value][data] to a ReturnChatPagedEventsStatus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReturnChatPagedEventsStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ACTIVE':
          return ReturnChatPagedEventsStatus.ACTIVE;
        case r'USER_ENDED':
          return ReturnChatPagedEventsStatus.USER_ENDED;
        case r'USER_TIMEOUT':
          return ReturnChatPagedEventsStatus.USER_TIMEOUT;
        case r'MAX_DURATION_TIMEOUT':
          return ReturnChatPagedEventsStatus.MAX_DURATION_TIMEOUT;
        case r'INACTIVITY_TIMEOUT':
          return ReturnChatPagedEventsStatus.INACTIVITY_TIMEOUT;
        case r'ERROR':
          return ReturnChatPagedEventsStatus.ERROR;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReturnChatPagedEventsStatusTypeTransformer] instance.
  static ReturnChatPagedEventsStatusTypeTransformer? _instance;
}
