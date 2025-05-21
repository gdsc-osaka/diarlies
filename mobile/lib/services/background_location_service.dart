import 'dart:async';
import 'dart:ui'; // DartPluginRegistrant.ensureInitialized() のために必要

import 'package:diarlies/logger.dart';
import 'package:diarlies/services/preferences_service.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_model/hive_model.dart';

import 'location_storage_service.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  print("FLUTTER BACKGROUND SERVICE: ON START");

  // DartPluginRegistrant.ensureInitialized() は、バックグラウンド isolate で
  // Flutter プラグイン (geolocatorなど) を使用するために必要です。
  DartPluginRegistrant.ensureInitialized();

  final locationStorage = LocationStorageService(); // Boxを開くために初期化が必要なら事前に行う
  // Hiveの初期化はmain isolateで行われている前提。もしBoxが閉じていたら再度開く処理が必要
  await LocationStorageService.initializeHive(); // バックグラウンドで必要なら

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  print("Background Service Started");

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        NotificationService.showNotification(
          title: "Diarlies Location Service",
          body: "Collecting location data in background periodically.",
        );
      }
    }
  });

  // 定期実行タイマー
  Timer.periodic(const Duration(minutes: 10), (timer) async {
    print("Background service running: ${DateTime.now()}");
    bool shouldStore = await PreferencesService.getShouldStoreLocation();
    List<LocationPoint> currentPoints = locationStorage.getAllLocationPoints();

    if (currentPoints.isEmpty || shouldStore) {
      print("Attempting to get current location...");
      try {
        // パーミッションチェック (geolocator内で処理されるが、明示的に行っても良い)
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          print("Location permission denied in background.");
          // 通知でユーザーに知らせるなどの対応も検討
          return;
        }
        if (permission == LocationPermission.whileInUse && !await Geolocator.isLocationServiceEnabled()){
          print("Location service is not enabled or permission is 'whileInUse' for background.");
          return;
        }


        final position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
            timeLimit: const Duration(seconds: 30),
          ),
        );
        final lastPoint = locationStorage.getLastLocationPoint();

        print("Current location: ${position.latitude}, ${position.longitude}");
        print("Last location: ${lastPoint?.lat}, ${lastPoint?.lng}");


        if (lastPoint == null || Geolocator.distanceBetween(
          lastPoint.lat,
          lastPoint.lng,
          position.latitude,
          position.longitude,
        ) >= 100) {
          final newPoint = LocationPoint(
            createdAt: DateTime.now(),
            lat: position.latitude,
            lng: position.longitude,
          );
          await locationStorage.addLocationPoint(newPoint);
          print("New location point saved: $newPoint");
        } else {
          print("Location not changed significantly or not storing.");
        }

      } catch (e) {
        print("Error getting location or saving: $e");
        // エラー発生時にも通知を更新するなどの処理が必要なら追加
      }
    } else {
      print("Not storing location based on flag and existing data.");
    }

    // iOSの場合、別途フォアグラウンドでの通知表示とは異なる仕組みになるため、
    // flutter_local_notifications を使って定期的に通知を更新するか、
    // またはサービスが動いていることを示す別の方法を検討します。
    // (iOSでは永続的な前景サービス通知はAndroidほど標準的ではありません)
  });
}

// iOS用バックグラウンドハンドラ (オプション)
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  print('FLUTTER BACKGROUND SERVICE: BG IS RUNNING');
  // iOSのバックグラウンドフェッチロジックなどをここに記述
  return true; // trueを返すとバックグラウンド処理を継続しようとする
}

Future<void> enableBackgroundService() async {
  logger.i('Initializing background service...');

  await NotificationService.initialize();
  await configureBackgroundService(autoStart: true);
}

Future<void> disableBackgroundService() async {
  final service = FlutterBackgroundService();
  service.invoke('stopService');
  logger.i('Background service disabled.');
  configureBackgroundService(autoStart: false);
}

Future<void> configureBackgroundService({required bool autoStart}) {
  return FlutterBackgroundService().configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: autoStart, // アプリ起動時に自動で開始 (必要に応じてfalseに)
      isForegroundMode: true, // フォアグラウンドサービスとして動作
      notificationChannelId: NotificationService.channelId, // 上記で定義したチャンネルID
      initialNotificationTitle: 'Diarlies collecting location',
      initialNotificationContent: 'Diarlies begins collecting location data after app closed or swiped away.',
      foregroundServiceNotificationId: NotificationService.notificationId,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true, // アプリ起動時に自動で開始
      onForeground: onStart, // フォアグラウンドになったときの処理
      onBackground: onIosBackground, // バックグラウンドになったときの処理 (オプション)
    ),
  );
}
