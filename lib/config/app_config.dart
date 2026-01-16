/// Centralized app configuration using compile-time constants.
/// 
/// Add new environment variables here and they'll be automatically
/// validated at compile time. No fallback values = maximum security.
class AppConfig {
  // Prevent instantiation
  AppConfig._();

  // Required environment variables (no fallbacks)
  static const String humeApiKey = String.fromEnvironment('HUME_API_KEY');
  
  // Optional environment variables (add defaults if needed)
  // static const String someOptionalVar = String.fromEnvironment('OPTIONAL_VAR', defaultValue: 'default_value');

  // Validation - will fail compilation if required vars are missing
  static void validate() {
    final requiredVars = <String, String>{
      'HUME_API_KEY': humeApiKey,
      // Add new required variables here
      // 'NEW_API_KEY': newApiKey,
    };

    final missingVars = requiredVars.entries
        .where((entry) => entry.value.isEmpty)
        .map((entry) => entry.key)
        .toList();

    if (missingVars.isNotEmpty) {
      throw Exception(
        'Missing required environment variables: ${missingVars.join(', ')}\n'
        'Provide them using: --dart-define=VAR_NAME=value\n'
        'Example: --dart-define=HUME_API_KEY=your_key_here',
      );
    }
  }
}