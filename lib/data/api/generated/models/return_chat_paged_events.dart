// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'return_chat_event.dart';
import 'return_chat_paged_events_pagination_direction.dart';
import 'return_chat_paged_events_status.dart';
import 'return_config_spec.dart';

part 'return_chat_paged_events.g.dart';

/// A description of chat status with a paginated list of chat events returned from the server
@JsonSerializable()
class ReturnChatPagedEvents {
  const ReturnChatPagedEvents({
    required this.chatGroupId,
    required this.config,
    required this.endTimestamp,
    required this.eventsPage,
    required this.id,
    required this.metadata,
    required this.pageNumber,
    required this.pageSize,
    required this.paginationDirection,
    required this.startTimestamp,
    required this.status,
    required this.totalPages,
  });
  
  factory ReturnChatPagedEvents.fromJson(Map<String, Object?> json) => _$ReturnChatPagedEventsFromJson(json);
  
  /// Identifier for the Chat Group. Any chat resumed from this Chat will have the same `chat_group_id`. Formatted as a UUID.
  @JsonKey(name: 'chat_group_id')
  final String chatGroupId;
  final ReturnConfigSpec config;

  /// Time at which the Chat ended. Measured in seconds since the Unix epoch.
  @JsonKey(name: 'end_timestamp')
  final int? endTimestamp;

  /// List of Chat Events for the specified `page_number` and `page_size`.
  @JsonKey(name: 'events_page')
  final List<ReturnChatEvent> eventsPage;

  /// Identifier for a Chat. Formatted as a UUID.
  final String id;

  /// Stringified JSON with additional metadata about the chat.
  final String? metadata;

  /// The page number of the returned list.
  ///
  /// This value corresponds to the `page_number` parameter specified in the request. Pagination uses zero-based indexing.
  @JsonKey(name: 'page_number')
  final int pageNumber;

  /// The maximum number of items returned per page.
  ///
  /// This value corresponds to the `page_size` parameter specified in the request.
  @JsonKey(name: 'page_size')
  final int pageSize;
  @JsonKey(name: 'pagination_direction')
  final ReturnChatPagedEventsPaginationDirection paginationDirection;

  /// Time at which the Chat started. Measured in seconds since the Unix epoch.
  @JsonKey(name: 'start_timestamp')
  final int? startTimestamp;
  final ReturnChatPagedEventsStatus status;

  /// The total number of pages in the collection.
  @JsonKey(name: 'total_pages')
  final int totalPages;

  Map<String, Object?> toJson() => _$ReturnChatPagedEventsToJson(this);
}
