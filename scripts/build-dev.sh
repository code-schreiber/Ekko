#!/bin/bash

# Development build script
# Usage: ./scripts/build-dev.sh

set -e

echo "🔨 Building Flutter app for Development environment..."

# Check if .env.dev file exists
if [ ! -f ".env.dev" ]; then
    echo "❌ .env.dev file not found. Please create it with your development secrets."
    exit 1
fi

# Load environment variables from .env.dev
export $(cat .env.dev | xargs)

# Build APK
flutter build apk --release \
  --dart-define=HUME_API_KEY=$HUME_API_KEY \
  --dart-define=HUME_CONFIG_ID=$HUME_CONFIG_ID \
  --dart-define=OPENAI_API_KEY=$OPENAI_API_KEY \
  --dart-define=HUME_API_BASE_URL=$HUME_API_BASE_URL \
  --dart-define=OPENAI_API_BASE_URL=$OPENAI_API_BASE_URL \
  --dart-define=OPENAI_MODEL=$OPENAI_MODEL \
  --dart-define=AUDIO_SAMPLE_RATE=$AUDIO_SAMPLE_RATE \
  --dart-define=AUDIO_ENCODING=$AUDIO_ENCODING \
  --dart-name=eko-dev.apk

echo "✅ Development build completed: build/app/outputs/flutter-apk/eko-dev.apk"