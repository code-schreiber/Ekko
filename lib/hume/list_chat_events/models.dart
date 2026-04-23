import 'dart:convert';

// Quick usage example (from OpenAPI spec):
// final sampleJson = '''<INSERT JSON HERE>''';
// final resp = ListChatEventsResponse.fromJson(sampleJson);
// print(resp.toJsonPretty());

// Dart data models for the List Chat Events endpoint, built from the
// OpenAPI spec in List chat events OpenAPI Specification.md.

// Enums representing API-discriminated strings.
enum ReturnChatEventRole { USER, AGENT, SYSTEM, TOOL }

enum ReturnChatEventType {
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
  USER_RECORDING_START_MESSAGE
}

enum ReturnChatPagedEventsPaginationDirection { ASC, DESC }

enum ReturnChatPagedEventsStatus {
  ACTIVE,
  USER_ENDED,
  USER_TIMEOUT,
  MAX_DURATION_TIMEOUT,
  INACTIVITY_TIMEOUT,
  ERROR
}

// Top-level response model for list-chat-events (paginated).
class ListChatEventsResponse {
  final String chatGroupId;
  final ReturnConfigSpec config;
  final int? endTimestamp;
  final List<ChatEvent> eventsPage;
  final String id;
  final String? metadata;
  final int pageNumber;
  final int pageSize;
  final ReturnChatPagedEventsPaginationDirection paginationDirection;
  final int startTimestamp;
  final ReturnChatPagedEventsStatus status;
  final int totalPages;

  ListChatEventsResponse({
    required this.chatGroupId,
    required this.config,
    this.endTimestamp,
    required this.eventsPage,
    required this.id,
    this.metadata,
    required this.pageNumber,
    required this.pageSize,
    required this.paginationDirection,
    required this.startTimestamp,
    required this.status,
    required this.totalPages,
  });

  // Pretty-print helper: returns a nicely indented JSON representation
  String toJsonPretty() {
    return const JsonEncoder.withIndent('  ').convert(toMap());
  }

  // Serialize to a plain Map for pretty-printing or further processing
  Map<String, dynamic> toMap() {
    return {
      'chat_group_id': chatGroupId,
      'config': config.toMap(),
      'end_timestamp': endTimestamp,
      'events_page': eventsPage.map((e) => e.toMap()).toList(),
      'id': id,
      'metadata': metadata,
      'page_number': pageNumber,
      'page_size': pageSize,
      'pagination_direction': paginationDirection.toString().split('.').last,
      'start_timestamp': startTimestamp,
      'status': status.toString().split('.').last,
      'total_pages': totalPages,
    };
  }

  factory ListChatEventsResponse.fromJson(String jsonStr) {
    final Map<String, dynamic> map =
        jsonDecode(jsonStr) as Map<String, dynamic>;
    return ListChatEventsResponse.fromMap(map);
  }

  factory ListChatEventsResponse.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      throw FormatException('Empty payload for ListChatEventsResponse');
    }
    final List<dynamic> eventsRaw = map['events_page'] as List<dynamic>;
    final List<ChatEvent> events = eventsRaw
        .map((e) => ChatEvent.fromMap(e as Map<String, dynamic>))
        .toList();

    return ListChatEventsResponse(
      chatGroupId: map['chat_group_id'] as String,
      config: ReturnConfigSpec.fromMap(map['config'] as Map<String, dynamic>),
      endTimestamp: map['end_timestamp'] as int?,
      eventsPage: events,
      id: map['id'] as String,
      metadata: map['metadata'] as String?,
      pageNumber: map['page_number'] as int,
      pageSize: map['page_size'] as int,
      paginationDirection:
          _parsePaginationDirection(map['pagination_direction'] as String)!,
      startTimestamp: map['start_timestamp'] as int,
      status: _parseStatus(map['status'] as String)!,
      totalPages: map['total_pages'] as int,
    );
  }

  // Helpers
  static ReturnChatPagedEventsPaginationDirection? _parsePaginationDirection(
      String? s) {
    if (s == null) return null;
    switch (s) {
      case 'ASC':
        return ReturnChatPagedEventsPaginationDirection.ASC;
      case 'DESC':
        return ReturnChatPagedEventsPaginationDirection.DESC;
      default:
        throw FormatException('Unknown pagination direction: $s');
    }
  }

  static ReturnChatPagedEventsStatus? _parseStatus(String? s) {
    if (s == null) return null;
    switch (s) {
      case 'ACTIVE':
        return ReturnChatPagedEventsStatus.ACTIVE;
      case 'USER_ENDED':
        return ReturnChatPagedEventsStatus.USER_ENDED;
      case 'USER_TIMEOUT':
        return ReturnChatPagedEventsStatus.USER_TIMEOUT;
      case 'MAX_DURATION_TIMEOUT':
        return ReturnChatPagedEventsStatus.MAX_DURATION_TIMEOUT;
      case 'INACTIVITY_TIMEOUT':
        return ReturnChatPagedEventsStatus.INACTIVITY_TIMEOUT;
      case 'ERROR':
        return ReturnChatPagedEventsStatus.ERROR;
      default:
        throw FormatException('Unknown status: $s');
    }
  }
}

// Nested config specification
class ReturnConfigSpec {
  final String id;
  final int? version;

  ReturnConfigSpec({required this.id, this.version});

  factory ReturnConfigSpec.fromMap(Map<String, dynamic> map) {
    return ReturnConfigSpec(
      id: map['id'] as String,
      version: map.containsKey('version') ? map['version'] as int? : null,
    );
  }
}

// Helpers to serialize nested types
extension _ReturnConfigSpecToMap on ReturnConfigSpec {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'version': version,
    };
  }
}

// Chat event payload
class ChatEvent {
  final String chatId;
  final String? emotionFeatures;
  final String id;
  final String? messageText;
  final String? metadata;
  final String? relatedEventId;
  final ReturnChatEventRole role;
  final int timestamp; // seconds since Unix epoch
  final ReturnChatEventType type;

  ChatEvent({
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

  factory ChatEvent.fromMap(Map<String, dynamic> map) {
    return ChatEvent(
      chatId: map['chat_id'] as String,
      emotionFeatures: map['emotion_features'] as String?,
      id: map['id'] as String,
      messageText: map['message_text'] as String?,
      metadata: map['metadata'] as String?,
      relatedEventId: map['related_event_id'] as String?,
      role: _parseRole(map['role'] as String)!,
      timestamp: map['timestamp'] as int,
      type: _parseEventType(map['type'] as String)!,
    );
  }
}

extension _ChatEventToMap on ChatEvent {
  Map<String, dynamic> toMap() {
    return {
      'chat_id': chatId,
      'emotion_features': emotionFeatures,
      'id': id,
      'message_text': messageText,
      'metadata': metadata,
      'related_event_id': relatedEventId,
      'role': role.toString().split('.').last,
      'timestamp': timestamp,
      'type': type.toString().split('.').last,
    };
  }
}

// Enum parsers
ReturnChatEventRole? _parseRole(String s) {
  switch (s) {
    case 'USER':
      return ReturnChatEventRole.USER;
    case 'AGENT':
      return ReturnChatEventRole.AGENT;
    case 'SYSTEM':
      return ReturnChatEventRole.SYSTEM;
    case 'TOOL':
      return ReturnChatEventRole.TOOL;
    default:
      throw FormatException('Unknown chat event role: $s');
  }
}

ReturnChatEventType? _parseEventType(String s) {
  switch (s) {
    case 'AGENT_MESSAGE':
      return ReturnChatEventType.AGENT_MESSAGE;
    case 'ASSISTANT_PROSODY':
      return ReturnChatEventType.ASSISTANT_PROSODY;
    case 'CHAT_START_MESSAGE':
      return ReturnChatEventType.CHAT_START_MESSAGE;
    case 'CHAT_END_MESSAGE':
      return ReturnChatEventType.CHAT_END_MESSAGE;
    case 'FUNCTION_CALL':
      return ReturnChatEventType.FUNCTION_CALL;
    case 'FUNCTION_CALL_RESPONSE':
      return ReturnChatEventType.FUNCTION_CALL_RESPONSE;
    case 'PAUSE_ONSET':
      return ReturnChatEventType.PAUSE_ONSET;
    case 'RESUME_ONSET':
      return ReturnChatEventType.RESUME_ONSET;
    case 'SESSION_SETTINGS':
      return ReturnChatEventType.SESSION_SETTINGS;
    case 'SYSTEM_PROMPT':
      return ReturnChatEventType.SYSTEM_PROMPT;
    case 'USER_INTERRUPTION':
      return ReturnChatEventType.USER_INTERRUPTION;
    case 'USER_MESSAGE':
      return ReturnChatEventType.USER_MESSAGE;
    case 'USER_RECORDING_START_MESSAGE':
      return ReturnChatEventType.USER_RECORDING_START_MESSAGE;
    default:
      throw FormatException('Unknown chat event type: $s');
  }
}
