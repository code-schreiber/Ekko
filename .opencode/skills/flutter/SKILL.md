---
name: flutter
description: Flutter project conventions and architecture patterns for this project
---

# Flutter Architecture

## Project Overview
This is a Flutter app integrating Hume's Empathic Voice Interface (EVI) API. It connects via WebSocket for real-time voice chat, processes emotional analysis, and stores session data.

## Architecture
- **State management**: Provider (ChangeNotifier)
- **Pattern**: Repository pattern + Service layer for data access
- **Layers**:
  - `lib/provider/` — ChangeNotifier providers (state management)
  - `lib/pages/` — Screen-level widgets
  - `lib/widgets/` — Reusable widgets
  - `lib/config/` — Static config files

## Key Architecture Rules
- Pages should NOT contain business logic or raw `Map<String, dynamic>` access
- Pages inject dependencies via Provider or constructor params
- Models use freezed for immutable data classes with JSON serialization
- Repositories return typed models, never raw maps
- Services contain domain logic (sorting, grouping, filtering)

## Key Files
| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry, Provider setup, navigation |
| `lib/provider/chat_provider.dart` | Global chat state, API calls |
| `lib/pages/my_home_page.dart` | EVI WebSocket connection + audio I/O |
| `lib/pages/sessions_page.dart` | Session history list |
| `lib/pages/emotion_page.dart` | Emotion analysis results + transcript |
| `lib/pages/analytics_page.dart` | Cross-session analytics with OpenAI |
| `lib/evi_message.dart` | EVI WebSocket message types |

## Tests
- Run: `flutter test`
- Analyze: `flutter analyze`
- Test files mirror `lib/` structure under `test/`
- Widget tests verify rendering and navigation

## Conventions
- No hardcoded strings for data access — use typed model properties
- API keys loaded from `.env` file via flutter_dotenv
- Keep pages focused on presentation, not data transformation
