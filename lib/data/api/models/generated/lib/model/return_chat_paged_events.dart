//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReturnChatPagedEvents {
  /// Returns a new [ReturnChatPagedEvents] instance.
  ReturnChatPagedEvents({
    required this.chatGroupId,
    this.config,
    this.endTimestamp,
    this.eventsPage = const [],
    required this.id,
    this.metadata,
    required this.pageNumber,
    required this.pageSize,
    required this.paginationDirection,
    required this.startTimestamp,
    required this.status,
    required this.totalPages,
  });

  /// Identifier for the Chat Group. Any chat resumed from this Chat will have the same `chat_group_id`. Formatted as a UUID.
  String chatGroupId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ReturnConfigSpec? config;

  /// Time at which the Chat ended. Measured in seconds since the Unix epoch.
  int? endTimestamp;

  /// List of Chat Events for the specified `page_number` and `page_size`.
  List<ReturnChatEvent> eventsPage;

  /// Identifier for a Chat. Formatted as a UUID.
  String id;

  /// Stringified JSON with additional metadata about the chat.
  String? metadata;

  /// The page number of the returned list.  This value corresponds to the `page_number` parameter specified in the request. Pagination uses zero-based indexing.
  int pageNumber;

  /// The maximum number of items returned per page.  This value corresponds to the `page_size` parameter specified in the request.
  int pageSize;

  ReturnChatPagedEventsPaginationDirection paginationDirection;

  /// Time at which the Chat started. Measured in seconds since the Unix epoch.
  int? startTimestamp;

  ReturnChatPagedEventsStatus status;

  /// The total number of pages in the collection.
  int totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReturnChatPagedEvents &&
          other.chatGroupId == chatGroupId &&
          other.config == config &&
          other.endTimestamp == endTimestamp &&
          _deepEquality.equals(other.eventsPage, eventsPage) &&
          other.id == id &&
          other.metadata == metadata &&
          other.pageNumber == pageNumber &&
          other.pageSize == pageSize &&
          other.paginationDirection == paginationDirection &&
          other.startTimestamp == startTimestamp &&
          other.status == status &&
          other.totalPages == totalPages;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (chatGroupId.hashCode) +
      (config == null ? 0 : config!.hashCode) +
      (endTimestamp == null ? 0 : endTimestamp!.hashCode) +
      (eventsPage.hashCode) +
      (id.hashCode) +
      (metadata == null ? 0 : metadata!.hashCode) +
      (pageNumber.hashCode) +
      (pageSize.hashCode) +
      (paginationDirection.hashCode) +
      (startTimestamp == null ? 0 : startTimestamp!.hashCode) +
      (status.hashCode) +
      (totalPages.hashCode);

  @override
  String toString() =>
      'ReturnChatPagedEvents[chatGroupId=$chatGroupId, config=$config, endTimestamp=$endTimestamp, eventsPage=$eventsPage, id=$id, metadata=$metadata, pageNumber=$pageNumber, pageSize=$pageSize, paginationDirection=$paginationDirection, startTimestamp=$startTimestamp, status=$status, totalPages=$totalPages]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'chat_group_id'] = this.chatGroupId;
    if (this.config != null) {
      json[r'config'] = this.config;
    } else {
      json[r'config'] = null;
    }
    if (this.endTimestamp != null) {
      json[r'end_timestamp'] = this.endTimestamp;
    } else {
      json[r'end_timestamp'] = null;
    }
    json[r'events_page'] = this.eventsPage;
    json[r'id'] = this.id;
    if (this.metadata != null) {
      json[r'metadata'] = this.metadata;
    } else {
      json[r'metadata'] = null;
    }
    json[r'page_number'] = this.pageNumber;
    json[r'page_size'] = this.pageSize;
    json[r'pagination_direction'] = this.paginationDirection;
    if (this.startTimestamp != null) {
      json[r'start_timestamp'] = this.startTimestamp;
    } else {
      json[r'start_timestamp'] = null;
    }
    json[r'status'] = this.status;
    json[r'total_pages'] = this.totalPages;
    return json;
  }

  /// Returns a new [ReturnChatPagedEvents] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReturnChatPagedEvents? fromJson(String value) {
    final data = jsonDecode(value);
    if (data is Map) {
      final json = data.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ReturnChatPagedEvents[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ReturnChatPagedEvents[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReturnChatPagedEvents(
        chatGroupId: mapValueOfType<String>(json, r'chat_group_id')!,
        config: ReturnConfigSpec.fromJson(json[r'config']),
        endTimestamp: mapValueOfType<int>(json, r'end_timestamp'),
        eventsPage: ReturnChatEvent.listFromJson(json[r'events_page']),
        id: mapValueOfType<String>(json, r'id')!,
        metadata: mapValueOfType<String>(json, r'metadata'),
        pageNumber: mapValueOfType<int>(json, r'page_number')!,
        pageSize: mapValueOfType<int>(json, r'page_size')!,
        paginationDirection: ReturnChatPagedEventsPaginationDirection.fromJson(
            json[r'pagination_direction'])!,
        startTimestamp: mapValueOfType<int>(json, r'start_timestamp'),
        status: ReturnChatPagedEventsStatus.fromJson(json[r'status'])!,
        totalPages: mapValueOfType<int>(json, r'total_pages')!,
      );
    }
    return null;
  }

  static List<ReturnChatPagedEvents> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ReturnChatPagedEvents>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReturnChatPagedEvents.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReturnChatPagedEvents> mapFromJson(dynamic json) {
    final map = <String, ReturnChatPagedEvents>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReturnChatPagedEvents.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReturnChatPagedEvents-objects as value to a dart map
  static Map<String, List<ReturnChatPagedEvents>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ReturnChatPagedEvents>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReturnChatPagedEvents.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'chat_group_id',
    'events_page',
    'id',
    'page_number',
    'page_size',
    'pagination_direction',
    'start_timestamp',
    'status',
    'total_pages',
  };
}
