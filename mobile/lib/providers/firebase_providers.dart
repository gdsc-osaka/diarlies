import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth auth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
FirebaseAnalytics analytics(Ref ref) => FirebaseAnalytics.instance;

@Riverpod(keepAlive: true)
FirebaseMessaging messaging(Ref ref) => FirebaseMessaging.instance;
