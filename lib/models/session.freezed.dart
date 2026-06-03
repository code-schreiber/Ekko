// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Session _$SessionFromJson(Map<String, dynamic> json) {
  return _Session.fromJson(json);
}

/// @nodoc
mixin _$Session {
  List<Map<String, dynamic>> get chatMessages =>
      throw _privateConstructorUsedError;
  Map<String, double> get emotions => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get diga => throw _privateConstructorUsedError;
  String get whatWentWell => throw _privateConstructorUsedError;
  String get challenges => throw _privateConstructorUsedError;

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call(
      {List<Map<String, dynamic>> chatMessages,
      Map<String, double> emotions,
      String createdAt,
      String priority,
      String diga,
      String whatWentWell,
      String challenges});
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatMessages = null,
    Object? emotions = null,
    Object? createdAt = null,
    Object? priority = null,
    Object? diga = null,
    Object? whatWentWell = null,
    Object? challenges = null,
  }) {
    return _then(_value.copyWith(
      chatMessages: null == chatMessages
          ? _value.chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      emotions: null == emotions
          ? _value.emotions
          : emotions // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      diga: null == diga
          ? _value.diga
          : diga // ignore: cast_nullable_to_non_nullable
              as String,
      whatWentWell: null == whatWentWell
          ? _value.whatWentWell
          : whatWentWell // ignore: cast_nullable_to_non_nullable
              as String,
      challenges: null == challenges
          ? _value.challenges
          : challenges // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
          _$SessionImpl value, $Res Function(_$SessionImpl) then) =
      __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Map<String, dynamic>> chatMessages,
      Map<String, double> emotions,
      String createdAt,
      String priority,
      String diga,
      String whatWentWell,
      String challenges});
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
      _$SessionImpl _value, $Res Function(_$SessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatMessages = null,
    Object? emotions = null,
    Object? createdAt = null,
    Object? priority = null,
    Object? diga = null,
    Object? whatWentWell = null,
    Object? challenges = null,
  }) {
    return _then(_$SessionImpl(
      chatMessages: null == chatMessages
          ? _value._chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      emotions: null == emotions
          ? _value._emotions
          : emotions // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      diga: null == diga
          ? _value.diga
          : diga // ignore: cast_nullable_to_non_nullable
              as String,
      whatWentWell: null == whatWentWell
          ? _value.whatWentWell
          : whatWentWell // ignore: cast_nullable_to_non_nullable
              as String,
      challenges: null == challenges
          ? _value.challenges
          : challenges // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionImpl implements _Session {
  const _$SessionImpl(
      {required final List<Map<String, dynamic>> chatMessages,
      required final Map<String, double> emotions,
      required this.createdAt,
      required this.priority,
      required this.diga,
      required this.whatWentWell,
      required this.challenges})
      : _chatMessages = chatMessages,
        _emotions = emotions;

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  final List<Map<String, dynamic>> _chatMessages;
  @override
  List<Map<String, dynamic>> get chatMessages {
    if (_chatMessages is EqualUnmodifiableListView) return _chatMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatMessages);
  }

  final Map<String, double> _emotions;
  @override
  Map<String, double> get emotions {
    if (_emotions is EqualUnmodifiableMapView) return _emotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_emotions);
  }

  @override
  final String createdAt;
  @override
  final String priority;
  @override
  final String diga;
  @override
  final String whatWentWell;
  @override
  final String challenges;

  @override
  String toString() {
    return 'Session(chatMessages: $chatMessages, emotions: $emotions, createdAt: $createdAt, priority: $priority, diga: $diga, whatWentWell: $whatWentWell, challenges: $challenges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            const DeepCollectionEquality()
                .equals(other._chatMessages, _chatMessages) &&
            const DeepCollectionEquality().equals(other._emotions, _emotions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.diga, diga) || other.diga == diga) &&
            (identical(other.whatWentWell, whatWentWell) ||
                other.whatWentWell == whatWentWell) &&
            (identical(other.challenges, challenges) ||
                other.challenges == challenges));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chatMessages),
      const DeepCollectionEquality().hash(_emotions),
      createdAt,
      priority,
      diga,
      whatWentWell,
      challenges);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionImplToJson(
      this,
    );
  }
}

abstract class _Session implements Session {
  const factory _Session(
      {required final List<Map<String, dynamic>> chatMessages,
      required final Map<String, double> emotions,
      required final String createdAt,
      required final String priority,
      required final String diga,
      required final String whatWentWell,
      required final String challenges}) = _$SessionImpl;

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  List<Map<String, dynamic>> get chatMessages;
  @override
  Map<String, double> get emotions;
  @override
  String get createdAt;
  @override
  String get priority;
  @override
  String get diga;
  @override
  String get whatWentWell;
  @override
  String get challenges;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
