import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'i18n/strings.g.dart';

bool initialized = false;

Future<bool> initializeApp() async {
  if (initialized) return false;

  WidgetsFlutterBinding.ensureInitialized(); // add this

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    //     .then((_) => Future.wait([
    //   FirebaseMessaging.instance.setAutoInitEnabled(true),
    // ])),
    LocaleSettings.useDeviceLocale(),
    Future.delayed(const Duration(seconds: 1)),
  ]);

  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  }

  initialized = true;

  return true;
}