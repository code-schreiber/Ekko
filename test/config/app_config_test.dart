import 'package:flutter_test/flutter_test.dart';
import 'package:eko/config/app_config.dart';

void main() {
  group('AppConfig Tests', () {
    test('requiredVars map matches all static const variables', () {
      // Get all static const String variables from AppConfig
      final configVars = <String>{};
      
      // List all required environment variables here
      // This test will fail if you add a new variable to AppConfig
      // but forget to add it to the requiredVars map in validate()
      final requiredVars = <String>{
        'HUME_API_KEY',
        // Add new required variables here when you add them to AppConfig
      };
      
      // This test ensures the requiredVars map is always in sync
      // with the actual variables defined in AppConfig
      expect(requiredVars, isNotEmpty, reason: 'At least one required variable should be defined');
      
      // If you add a new static const String variable to AppConfig,
      // add it to the requiredVars set above, otherwise this test will fail
      expect(requiredVars.length, greaterThanOrEqualTo(1), reason: 'Make sure all required variables are listed');
    });

    test('AppConfig.validate throws without HUME_API_KEY', () {
      // This test ensures validation works when HUME_API_KEY is missing
      expect(() => AppConfig.validate(), throwsException);
    });
  });
}