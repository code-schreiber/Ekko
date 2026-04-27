//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReturnChatEventRole {
  /// Instantiate a new enum with the provided [value].
  const ReturnChatEventRole._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const USER = ReturnChatEventRole._(r'USER');
  static const AGENT = ReturnChatEventRole._(r'AGENT');
  static const SYSTEM = ReturnChatEventRole._(r'SYSTEM');
  static const TOOL = ReturnChatEventRole._(r'TOOL');

  /// List of all possible values in this [enum][ReturnChatEventRole].
  static const values = <ReturnChatEventRole>[
    USER,
    AGENT,
    SYSTEM,
    TOOL,
  ];

  static ReturnChatEventRole? fromJson(dynamic value) =>
      ReturnChatEventRoleTypeTransformer().decode(value);

  static List<ReturnChatEventRole> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ReturnChatEventRole>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReturnChatEventRole.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReturnChatEventRole] to String,
/// and [decode] dynamic data back to [ReturnChatEventRole].
class ReturnChatEventRoleTypeTransformer {
  factory ReturnChatEventRoleTypeTransformer() =>
      _instance ??= const ReturnChatEventRoleTypeTransformer._();

  const ReturnChatEventRoleTypeTransformer._();

  String encode(ReturnChatEventRole data) => data.value;

  /// Decodes a [dynamic value][data] to a ReturnChatEventRole.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReturnChatEventRole? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'USER':
          return ReturnChatEventRole.USER;
        case r'AGENT':
          return ReturnChatEventRole.AGENT;
        case r'SYSTEM':
          return ReturnChatEventRole.SYSTEM;
        case r'TOOL':
          return ReturnChatEventRole.TOOL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReturnChatEventRoleTypeTransformer] instance.
  static ReturnChatEventRoleTypeTransformer? _instance;
}
