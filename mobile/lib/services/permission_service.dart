import 'dart:io';

import 'package:diarlies/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart' as l;
import 'package:photo_manager/photo_manager.dart' as p;

class PermissionService {
  Future<PermissionStatus> locationStatus() {
    return l.Location().hasPermission().then(fromLocationStatus);
  }

  Future<PermissionStatus> requestLocationPermission() async {
    final status = await locationStatus();

    if (status == PermissionStatus.granted) {
      return status;
    }

    final res = await l.Location().requestPermission();
    return fromLocationStatus(res);
  }

  Future<PermissionStatus> photoStatus() {
    return p.PhotoManager.getPermissionState(
      requestOption: p.PermissionRequestOption(
        iosAccessLevel: p.IosAccessLevel.readWrite,
        androidPermission: p.AndroidPermission(type: p.RequestType.common, mediaLocation: false),
      ),
    ).then(fromPhotoStatus);
  }

  Future<PermissionStatus> requestPhotoPermission() async {
    final status = await photoStatus();

    if (status == PermissionStatus.granted) {
      return status;
    }

    if (status == PermissionStatus.grantedLimited) {
      await p.PhotoManager.openSetting();
      return photoStatus();
    }
    final res = await p.PhotoManager.requestPermissionExtend();
    return fromPhotoStatus(res);
  }

  Future<PermissionStatus> notificationStatus() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // iOS
    if (Platform.isIOS) {
      final iosPlugin =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

      if (iosPlugin == null) {
        logger.w("iOS plugin not found");
        return PermissionStatus.denied;
      }

      final notificationOptions = await iosPlugin.checkPermissions();

      if (notificationOptions == null) {
        logger.w("Notification options not found");
        return PermissionStatus.denied;
      }

      return notificationOptions.isAlertEnabled && notificationOptions.isBadgeEnabled
          ? PermissionStatus.granted
          : PermissionStatus.denied;
    }

    // Android 13 (API レベル 33) 以降で必要
    final androidPlugin =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) {
      logger.w("Android plugin not found");
      return PermissionStatus.denied;
    }

    final granted = await androidPlugin.areNotificationsEnabled();
    return granted == true ? PermissionStatus.granted : PermissionStatus.denied;
  }

  Future<PermissionStatus> requestNotificationPermission() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // iOS
    if (Platform.isIOS) {
      final iosPlugin =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

      if (iosPlugin == null) {
        logger.w("iOS plugin not found");
        return PermissionStatus.denied;
      }

      final granted = await iosPlugin.requestPermissions(alert: true, badge: true);
      return granted == true ? PermissionStatus.granted : PermissionStatus.denied;
    }

    // Android 13 (API レベル 33) 以降で必要
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) {
      logger.w("Android plugin not found");
      return PermissionStatus.denied;
    }

    final granted = await androidPlugin.requestNotificationsPermission();
    return granted == true ? PermissionStatus.granted : PermissionStatus.denied;
  }
}

enum PermissionStatus { granted, grantedLimited, denied, deniedForever }

PermissionStatus fromLocationStatus(l.PermissionStatus status) {
  return switch (status) {
    l.PermissionStatus.granted => PermissionStatus.granted,
    l.PermissionStatus.denied => PermissionStatus.denied,
    l.PermissionStatus.deniedForever => PermissionStatus.deniedForever,
    l.PermissionStatus.grantedLimited => PermissionStatus.grantedLimited,
  };
}

PermissionStatus fromPhotoStatus(p.PermissionState status) {
  return switch (status) {
    p.PermissionState.authorized => PermissionStatus.granted,
    p.PermissionState.denied => PermissionStatus.denied,
    p.PermissionState.limited => PermissionStatus.grantedLimited,
    p.PermissionState.restricted => PermissionStatus.deniedForever,
    p.PermissionState.notDetermined => PermissionStatus.denied,
  };
}
