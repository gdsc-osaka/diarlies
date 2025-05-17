ENV_PROD=../dart_defines/.env.prod

# if androidGoogleMapApiKey is set, write it to the .env.prod file. otherwise, use fake value
if [ -z "$androidGoogleMapApiKey" ]; then
  echo "androidGoogleMapApiKey is not set. Using fake value."
  echo "androidGoogleMapApiKey=FAKE_ANDROID_GOOGLE_MAP_API_KEY" > "$ENV_PROD"
else
  echo "androidGoogleMapApiKey is set. Using real value."
  echo "androidGoogleMapApiKey=$androidGoogleMapApiKey" >> "$ENV_PROD"
fi

# if iosGoogleMapApiKey is set, write it to the .env.prod file. otherwise, use fake value
if [ -z "$iosGoogleMapApiKey" ]; then
  echo "iosGoogleMapApiKey is not set. Using fake value."
  echo "iosGoogleMapApiKey=FAKE_IOS_GOOGLE_MAP_API_KEY" >> "$ENV_PROD"
else
  echo "iosGoogleMapApiKey is set. Using real value."
  echo "iosGoogleMapApiKey=$iosGoogleMapApiKey" >> "$ENV_PROD"
fi