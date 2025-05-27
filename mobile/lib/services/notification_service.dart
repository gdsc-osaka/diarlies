import 'package:diarlies/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static const int notificationId = 888;
  static const String channelId = "diarlies_location_service";
  static const String _channelName = "Diarlies Location Service";
  static const String _channelDescription = "Notification for Diarlies Location Service";

  static Future<void> initialize() async {
    await _notificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_stat'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false, // バックグラウンドサービス側で制御する場合
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );

    final androidImplementation =
        _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      // 通知チャンネルをシステムに登録
      await androidImplementation.createNotificationChannel(
        AndroidNotificationChannel(
          channelId, // ID (flutter_background_service の AndroidConfiguration で指定したものと同じ)
          _channelName, // ユーザーに表示されるチャンネル名
          description: _channelDescription, // ユーザーに表示されるチャンネルの説明
          importance: Importance.low, // フォアグラウンドサービス通知は Importance.low で十分なことが多いです。
        ),
      );
      logger.i("Notification channel created.");
    } else {
      logger.i("AndroidFlutterLocalNotificationsPlugin is null, channel not created.");
    }
  }

  static Future<void> showNotification({required String title, required String body}) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.low,
        // 永続的な通知なのでLowに
        priority: Priority.low,
        ongoing: true,
        // 消えにくい通知 (フォアグラウンドサービス用)
        autoCancel: false,
        icon: '@drawable/ic_stat',
      ),
      iOS: DarwinNotificationDetails(
        presentSound: false,
        presentBadge: false,
        presentAlert: false,
      ), // iOSはサービス側でどう見せるか次第
    );

    await _notificationsPlugin.show(notificationId, title, body, notificationDetails);
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
