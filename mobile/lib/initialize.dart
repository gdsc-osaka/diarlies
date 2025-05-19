import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'env.dart';
import 'firebase_options.dart';
import 'i18n/strings.g.dart';
import 'services/location_storage_service.dart';

bool initialized = false;

Future<bool> initializeApp() async {
  if (initialized) return false;

  WidgetsFlutterBinding.ensureInitialized(); // add this

  initialized = true;

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    //     .then((_) => Future.wait([
    //   FirebaseMessaging.instance.setAutoInitEnabled(true),
    // ])),
    LocaleSettings.useDeviceLocale(),
    LocationStorageService.initializeHive(),
    Future.delayed(const Duration(seconds: 1)),
  ]);

  if (isDebug) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  }

  return true;
}