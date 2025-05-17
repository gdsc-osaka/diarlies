#!/bin/sh

bash ./env.sh

# iOS dart defines setup
XCCONFIG_FILE=ios/Flutter/DartDefine.xcconfig

ENV_DEV=dart_defines/.env.dev
ENV_PROD=dart_defines/.env.prod

if [ -f "$ENV_DEV" ]; then
  cat "$ENV_DEV" > "$XCCONFIG_FILE"
  echo "Copied .env.dev to $XCCONFIG_FILE"
else
  echo "Warning: .env.dev not found. $XCCONFIG_FILE will not be created from it."
fi

if [ -f "$ENV_PROD" ]; then
  cat "$ENV_PROD" > "$XCCONFIG_FILE"
  echo "Copied .env.prod to $XCCONFIG_FILE"
else
  echo "Warning: .env.prod not found. $XCCONFIG_FILE will not be created from it."
fi
