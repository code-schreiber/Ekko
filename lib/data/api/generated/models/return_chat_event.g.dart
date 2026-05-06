// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_chat_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnChatEvent _$ReturnChatEventFromJson(Map<String, dynamic> json) =>
    ReturnChatEvent(
      chatId: json['chat_id'] as String,
      emotionFeatures: json['emotion_features'] as String?,
      id: json['id'] as String,
      messageText: json['message_text'] as String?,
      metadata: json['metadata'] as String?,
      relatedEventId: json['related_event_id'] as String?,
      role: ReturnChatEventRole.fromJson(json['role'] as String),
      timestamp: (json['timestamp'] as num).toInt(),
      type: ReturnChatEventType.fromJson(json['type'] as String),
    );

Map<String, dynamic> _$ReturnChatEventToJson(ReturnChatEvent instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'emotion_features': instance.emotionFeatures,
      'id': instance.id,
      'message_text': instance.messageText,
      'metadata': instance.metadata,
      'related_event_id': instance.relatedEventId,
      'role': _$ReturnChatEventRoleEnumMap[instance.role]!,
      'timestamp': instance.timestamp,
      'type': _$ReturnChatEventTypeEnumMap[instance.type]!,
    };

const _$ReturnChatEventRoleEnumMap = {
  ReturnChatEventRole.user: 'USER',
  ReturnChatEventRole.agent: 'AGENT',
  ReturnChatEventRole.system: 'SYSTEM',
  ReturnChatEventRole.tool: 'TOOL',
  ReturnChatEventRole.$unknown: r'$unknown',
};

const _$ReturnChatEventTypeEnumMap = {
  ReturnChatEventType.agentMessage: 'AGENT_MESSAGE',
  ReturnChatEventType.assistantProsody: 'ASSISTANT_PROSODY',
  ReturnChatEventType.chatStartMessage: 'CHAT_START_MESSAGE',
  ReturnChatEventType.chatEndMessage: 'CHAT_END_MESSAGE',
  ReturnChatEventType.functionCall: 'FUNCTION_CALL',
  ReturnChatEventType.functionCallResponse: 'FUNCTION_CALL_RESPONSE',
  ReturnChatEventType.pauseOnset: 'PAUSE_ONSET',
  ReturnChatEventType.resumeOnset: 'RESUME_ONSET',
  ReturnChatEventType.sessionSettings: 'SESSION_SETTINGS',
  ReturnChatEventType.systemPrompt: 'SYSTEM_PROMPT',
  ReturnChatEventType.userInterruption: 'USER_INTERRUPTION',
  ReturnChatEventType.userMessage: 'USER_MESSAGE',
  ReturnChatEventType.userRecordingStartMessage: 'USER_RECORDING_START_MESSAGE',
  ReturnChatEventType.$unknown: r'$unknown',
};
