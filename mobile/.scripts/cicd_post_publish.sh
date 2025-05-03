# Upload dSYM to Firebase Crashlytics
echo "Finding build artifacts..."
dsymPath=$(find build/ios/archive/Runner.xcarchive -name "*.dSYM" | head -1)

if [[ -z $dsymPath ]]; then
  echo "No debug symbols were found, skip publishing to Firebase Crashlytics."
else
  echo "Publishing debug symbols from $dsymPath to Firebase Crashlytics..."
  ios/Pods/FirebaseCrashlytics/upload-symbols -gsp ios/Runner/GoogleService-Info.plist -p ios $dsymPath || echo "Failed to upload dSYM to Firebase Crashlytics"
fi
