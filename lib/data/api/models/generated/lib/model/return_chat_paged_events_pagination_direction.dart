//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReturnChatPagedEventsPaginationDirection {
  /// Instantiate a new enum with the provided [value].
  const ReturnChatPagedEventsPaginationDirection._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ASC = ReturnChatPagedEventsPaginationDirection._(r'ASC');
  static const DESC = ReturnChatPagedEventsPaginationDirection._(r'DESC');

  /// List of all possible values in this [enum][ReturnChatPagedEventsPaginationDirection].
  static const values = <ReturnChatPagedEventsPaginationDirection>[
    ASC,
    DESC,
  ];

  static ReturnChatPagedEventsPaginationDirection? fromJson(dynamic value) =>
      ReturnChatPagedEventsPaginationDirectionTypeTransformer().decode(value);

  static List<ReturnChatPagedEventsPaginationDirection> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ReturnChatPagedEventsPaginationDirection>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReturnChatPagedEventsPaginationDirection.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReturnChatPagedEventsPaginationDirection] to String,
/// and [decode] dynamic data back to [ReturnChatPagedEventsPaginationDirection].
class ReturnChatPagedEventsPaginationDirectionTypeTransformer {
  factory ReturnChatPagedEventsPaginationDirectionTypeTransformer() =>
      _instance ??=
          const ReturnChatPagedEventsPaginationDirectionTypeTransformer._();

  const ReturnChatPagedEventsPaginationDirectionTypeTransformer._();

  String encode(ReturnChatPagedEventsPaginationDirection data) => data.value;

  /// Decodes a [dynamic value][data] to a ReturnChatPagedEventsPaginationDirection.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReturnChatPagedEventsPaginationDirection? decode(dynamic data,
      {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ASC':
          return ReturnChatPagedEventsPaginationDirection.ASC;
        case r'DESC':
          return ReturnChatPagedEventsPaginationDirection.DESC;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReturnChatPagedEventsPaginationDirectionTypeTransformer] instance.
  static ReturnChatPagedEventsPaginationDirectionTypeTransformer? _instance;
}
