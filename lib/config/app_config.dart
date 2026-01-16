import 'package:flutter/foundation.dart';

/// Centralized application configuration using compile-time constants.
/// 
/// All configuration values are passed via --dart-define flags during build,
/// ensuring compile-time safety and CI/CD compatibility.
/// 
/// Required environment variables will cause compilation to fail if not provided.
class AppConfig {
  // Prevent instantiation
  AppConfig._();

  // Hume API Configuration
  static const String humeApiKey = String.fromEnvironment(
    'HUME_API_KEY',
    defaultValue: 'MISSING_HUME_API_KEY',
  );
  
  static const String humeConfigId = String.fromEnvironment(
    'HUME_CONFIG_ID',
    defaultValue: 'MISSING_HUME_CONFIG_ID',
  );

  // OpenAI API Configuration
  static const String openAiApiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: 'MISSING_OPENAI_API_KEY',
  );

  // API Endpoints
  static const String humeApiBaseUrl = String.fromEnvironment(
    'HUME_API_BASE_URL',
    defaultValue: 'https://api.hume.ai',
  );
  
  static const String humeWebSocketUrl = String.fromEnvironment(
    'HUME_WEBSOCKET_URL',
    defaultValue: 'wss://api.hume.ai/v0/evi/chat',
  );
  
  static const String openAiApiBaseUrl = String.fromEnvironment(
    'OPENAI_API_BASE_URL',
    defaultValue: 'https://api.openai.com',
  );

  // AI Model Configuration
  static const String openAiModel = String.fromEnvironment(
    'OPENAI_MODEL',
    defaultValue: 'gpt-4o-mini',
  );

  // Audio Configuration
  static const int audioSampleRate = int.fromEnvironment(
    'AUDIO_SAMPLE_RATE',
    defaultValue: 48000,
  );
  
  static const String audioEncoding = String.fromEnvironment(
    'AUDIO_ENCODING',
    defaultValue: 'linear16',
  );

  // HTTP Configuration
  static const Duration httpTimeout = Duration(
    seconds: int.fromEnvironment(
      'HTTP_TIMEOUT_SECONDS',
      defaultValue: 30,
    ),
  );

  // Environment Detection
  static bool get isProduction => kReleaseMode;
  static bool get isDevelopment => kDebugMode;
  
  // Validation
  static void validate() {
    final requiredVars = {
      'HUME_API_KEY': humeApiKey,
      'HUME_CONFIG_ID': humeConfigId,
      'OPENAI_API_KEY': openAiApiKey,
    };

    final missingVars = requiredVars.entries
        .where((entry) => entry.value.startsWith('MISSING_'))
        .map((entry) => entry.key)
        .toList();

    if (missingVars.isNotEmpty) {
      throw Exception(
        'Missing required environment variables: ${missingVars.join(', ')}\n'
        'Please provide them using --dart-define flags:\n'
        missingVars.map((varName) => '  --dart-define=$varName=your_value').join('\n'),
      );
    }
  }

  // Convenience getters for full URLs
  static String get humeChatUrl => '$humeApiBaseUrl/v0/evi/chats';
  static String get openAiChatUrl => '$openAiApiBaseUrl/v1/chat/completions';
}