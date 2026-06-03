// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      chatMessages: (json['chatMessages'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      emotions: (json['emotions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      createdAt: json['createdAt'] as String,
      priority: json['priority'] as String,
      diga: json['diga'] as String,
      whatWentWell: json['whatWentWell'] as String,
      challenges: json['challenges'] as String,
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'chatMessages': instance.chatMessages,
      'emotions': instance.emotions,
      'createdAt': instance.createdAt,
      'priority': instance.priority,
      'diga': instance.diga,
      'whatWentWell': instance.whatWentWell,
      'challenges': instance.challenges,
    };
