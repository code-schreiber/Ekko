## List Chat Events Parser (Dart)

Typed Dart models for parsing the List Chat Events response from HUME's API, using only default JSON handling (dart:convert).

- Top-level model: `ListChatEventsResponse`
- Nested models: `ReturnConfigSpec`, `ChatEvent` with dedicated classes for nested structures
- No HTTP client code is included; this is strictly a parsing/mapping layer.

Getting started
- Import and parse a JSON payload string with fromJson:

```dart
import 'package:evi_example/hume/list_chat_events/models.dart';

void main() {
  final jsonStr = '{ /* your JSON payload here as a string */ }';
  final listResp = ListChatEventsResponse.fromJson(jsonStr);
  print(listResp.toJsonPretty());
}
```

Notes
- The README describes the exact JSON shape derived from the OpenAPI spec in the repository.
- Use ListChatEventsResponse.fromJson for unit-test payload strings and resp.toJsonPretty() for debugging or logs.
- Tests in test/hume/list_chat_events_parser_test.dart exercise representative payloads and edge cases.

If you add more payloads, extend the tests accordingly and use toJsonPretty() to inspect mapping results.
