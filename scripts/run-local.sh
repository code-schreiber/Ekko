#!/bin/bash

# Local development run script
# Usage: ./scripts/run-local.sh

set -e

echo "🏃 Running Flutter app locally..."

# Check if .env.local file exists
if [ ! -f ".env.local" ]; then
    echo "❌ .env.local file not found. Please create it with your local development secrets."
    exit 1
fi

# Load environment variables from .env.local
export $(cat .env.local | xargs)

# Run the app with dart-define flags
flutter run \
  --dart-define=HUME_API_KEY=$HUME_API_KEY \
  --dart-define=HUME_CONFIG_ID=$HUME_CONFIG_ID \
  --dart-define=OPENAI_API_KEY=$OPENAI_API_KEY \
  --dart-define=HUME_API_BASE_URL=$HUME_API_BASE_URL \
  --dart-define=OPENAI_API_BASE_URL=$OPENAI_API_BASE_URL \
  --dart-define=OPENAI_MODEL=$OPENAI_MODEL \
  --dart-define=AUDIO_SAMPLE_RATE=$AUDIO_SAMPLE_RATE \
  --dart-define=AUDIO_ENCODING=$AUDIO_ENCODING