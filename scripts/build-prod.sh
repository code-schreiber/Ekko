#!/bin/bash

# Production build script
# Usage: ./scripts/build-prod.sh

set -e

echo "🚀 Building Flutter app for Production environment..."

# Check if .env.prod file exists
if [ ! -f ".env.prod" ]; then
    echo "❌ .env.prod file not found. Please create it with your production secrets."
    exit 1
fi

# Load environment variables from .env.prod
export $(cat .env.prod | xargs)

# Build APK for production
flutter build apk --release \
  --dart-define=HUME_API_KEY=$HUME_API_KEY \
  --dart-define=HUME_CONFIG_ID=$HUME_CONFIG_ID \
  --dart-define=OPENAI_API_KEY=$OPENAI_API_KEY \
  --dart-define=HUME_API_BASE_URL=$HUME_API_BASE_URL \
  --dart-define=OPENAI_API_BASE_URL=$OPENAI_API_BASE_URL \
  --dart-define=OPENAI_MODEL=$OPENAI_MODEL \
  --dart-define=AUDIO_SAMPLE_RATE=$AUDIO_SAMPLE_RATE \
  --dart-define=AUDIO_ENCODING=$AUDIO_ENCODING \
  --dart-name=eko-prod.apk

echo "✅ Production build completed: build/app/outputs/flutter-apk/eko-prod.apk"