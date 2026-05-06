// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_chat_paged_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnChatPagedEvents _$ReturnChatPagedEventsFromJson(
        Map<String, dynamic> json) =>
    ReturnChatPagedEvents(
      chatGroupId: json['chat_group_id'] as String,
      config: ReturnConfigSpec.fromJson(json['config'] as Map<String, dynamic>),
      endTimestamp: (json['end_timestamp'] as num?)?.toInt(),
      eventsPage: (json['events_page'] as List<dynamic>)
          .map((e) => ReturnChatEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String,
      metadata: json['metadata'] as String?,
      pageNumber: (json['page_number'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      paginationDirection: ReturnChatPagedEventsPaginationDirection.fromJson(
          json['pagination_direction'] as String),
      startTimestamp: (json['start_timestamp'] as num?)?.toInt(),
      status: ReturnChatPagedEventsStatus.fromJson(json['status'] as String),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$ReturnChatPagedEventsToJson(
        ReturnChatPagedEvents instance) =>
    <String, dynamic>{
      'chat_group_id': instance.chatGroupId,
      'config': instance.config,
      'end_timestamp': instance.endTimestamp,
      'events_page': instance.eventsPage,
      'id': instance.id,
      'metadata': instance.metadata,
      'page_number': instance.pageNumber,
      'page_size': instance.pageSize,
      'pagination_direction': _$ReturnChatPagedEventsPaginationDirectionEnumMap[
          instance.paginationDirection]!,
      'start_timestamp': instance.startTimestamp,
      'status': _$ReturnChatPagedEventsStatusEnumMap[instance.status]!,
      'total_pages': instance.totalPages,
    };

const _$ReturnChatPagedEventsPaginationDirectionEnumMap = {
  ReturnChatPagedEventsPaginationDirection.asc: 'ASC',
  ReturnChatPagedEventsPaginationDirection.desc: 'DESC',
  ReturnChatPagedEventsPaginationDirection.$unknown: r'$unknown',
};

const _$ReturnChatPagedEventsStatusEnumMap = {
  ReturnChatPagedEventsStatus.active: 'ACTIVE',
  ReturnChatPagedEventsStatus.userEnded: 'USER_ENDED',
  ReturnChatPagedEventsStatus.userTimeout: 'USER_TIMEOUT',
  ReturnChatPagedEventsStatus.maxDurationTimeout: 'MAX_DURATION_TIMEOUT',
  ReturnChatPagedEventsStatus.inactivityTimeout: 'INACTIVITY_TIMEOUT',
  ReturnChatPagedEventsStatus.error: 'ERROR',
  ReturnChatPagedEventsStatus.$unknown: r'$unknown',
};
