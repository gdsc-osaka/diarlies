import 'dart:async';
import 'dart:ui'; // DartPluginRegistrant.ensureInitialized() のために必要

import 'package:diarlies/services/preferences_service.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_model/hive_model.dart';

import 'location_storage_service.dart';
import 'notification_service.dart';

const int notificationId = 888;
const String notificationChannelId = 'my_foreground';

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  // DartPluginRegistrant.ensureInitialized() は、バックグラウンド isolate で
  // Flutter プラグイン (geolocatorなど) を使用するために必要です。
  DartPluginRegistrant.ensureInitialized();

  final locationStorage = LocationStorageService(); // Boxを開くために初期化が必要なら事前に行う
  // Hiveの初期化はmain isolateで行われている前提。もしBoxが閉じていたら再度開く処理が必要
  // await LocationStorageService.initializeHive(); // バックグラウンドで必要なら

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

  // 定期実行タイマー
  Timer.periodic(const Duration(minutes: 15), (timer) async {
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


        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium // バッテリー消費を考慮
        );
        print("Current location: ${position.latitude}, ${position.longitude}");

        LocationPoint? lastPoint = locationStorage.getLastLocationPoint();
        bool saveLocation = true;

        if (lastPoint != null) {
          double distance = Geolocator.distanceBetween(
            lastPoint.lat,
            lastPoint.lng,
            position.latitude,
            position.longitude,
          );
          print("Distance from last point: $distance meters");
          if (distance < 100.0) { // 100m以上離れていない場合
            saveLocation = false;
          }
        }

        if (saveLocation) {
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

    // バックグラウンド処理が実行中であることを示す通知
    // Androidの場合、setAsForegroundService() を呼ぶと自動で通知が表示されることが多い
    // ここではその通知内容を更新するイメージ
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        NotificationService.showNotification(
          id: notificationId,
          title: "位置情報サービス実行中",
          body: "バックグラウンドで現在地を監視しています (${DateTime.now().toLocal().toString().substring(0,16)})",
        );
      }
    }
    // iOSの場合、別途フォアグラウンドでの通知表示とは異なる仕組みになるため、
    // flutter_local_notifications を使って定期的に通知を更新するか、
    // またはサービスが動いていることを示す別の方法を検討します。
    // (iOSでは永続的な前景サービス通知はAndroidほど標準的ではありません)
  });
}


Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  // Android の通知チャンネル設定
  // flutter_local_notifications で設定したチャンネルIDと合わせる
  // あるいは、flutter_background_service が独自に作成する通知を利用する
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, // 'my_foreground'
    'MY FOREGROUND SERVICE', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.low, // Low or Default. Highは避ける
  );

  await NotificationService.initialize(); // ローカル通知サービスの初期化

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true, // アプリ起動時に自動で開始 (必要に応じてfalseに)
      isForegroundMode: true, // フォアグラウンドサービスとして動作
      notificationChannelId: notificationChannelId, // 上記で定義したチャンネルID
      initialNotificationTitle: '位置情報サービス',
      initialNotificationContent: '初期化しています...',
      foregroundServiceNotificationId: notificationId,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true, // アプリ起動時に自動で開始
      onForeground: onStart, // フォアグラウンドになったときの処理
      onBackground: onIosBackground, // バックグラウンドになったときの処理 (オプション)
    ),
  );
  // サービスを開始する場合 (autoStart: false の時)
  // service.startService();
}

// iOS用バックグラウンドハンドラ (オプション)
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  print('FLUTTER BACKGROUND SERVICE: BG IS RUNNING');
  // iOSのバックグラウンドフェッチロジックなどをここに記述
  return true; // trueを返すとバックグラウンド処理を継続しようとする
}
