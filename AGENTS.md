# OpenCode Configuration for Eko Project

## Project Overview
Eko is a Flutter application implementing Hume's Empathic Voice Interface (EVI). The project includes voice chat capabilities, emotion analytics, session management, and real-time transcription features.

## Development Commands

### Dependencies
```bash
flutter pub get
```

### Build & Run
```bash
flutter run                    # Run in debug mode
flutter build apk             # Build Android APK
flutter build ios             # Build iOS app
flutter build web             # Build web version
```

### Code Generation
```bash
flutter packages pub run build_runner build    # Generate code for freezed/json_serializable
flutter packages pub run build_runner watch    # Watch for changes and auto-generate
```

### Linting & Analysis
```bash
flutter analyze               # Run static analysis
dart format .                 # Format all Dart files
```

### Testing
```bash
flutter test                  # Run all tests
flutter test --coverage       # Run tests with coverage
```

## Project Structure
```
lib/
├── main.dart                 # App entry point
├── pages/                    # Screen implementations
│   ├── my_home_page.dart
│   ├── analytics_page.dart
│   ├── emotion_page.dart
│   ├── settings_page.dart
│   ├── sessions_page.dart
│   └── transcript_page.dart
├── widgets/                  # Reusable UI components
│   ├── nav_bar.dart
│   └── radar_chart_widget.dart
├── provider/                 # State management
│   ├── chat_provider.dart
│   └── initial_sessions.dart
├── evi_message.dart          # Message models
├── chat_card.dart           # Chat UI components
├── theme.dart               # App theming
└── utils.dart               # Utility functions
```

## Key Dependencies
- `web_socket_channel`: EVI WebSocket connection
- `record`: Audio recording
- `audioplayers`: Audio playback
- `provider`: State management
- `fl_chart`: Analytics charts
- `freezed`: Immutable data classes
- `flutter_dotenv`: Environment variables

## Environment Setup
Copy `.env.example` to `.env` and configure:
- `HUME_API_KEY`: Your Hume API key
- `HUME_CONFIG_ID`: EVI configuration ID

## Notes
- This is a voice-first application with real-time audio processing
- Echo cancellation is important for proper EVI functionality
- The app supports iOS, Android, and Web platforms