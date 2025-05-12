import 'package:location/location.dart' as l;
import 'package:photo_manager/photo_manager.dart' as p;

class PermissionService {
  Future<PermissionStatus> locationStatus() {
    return l.Location().hasPermission().then(fromLocationStatus);
  }

  Future<PermissionStatus> photoStatus() {
    return p.PhotoManager.getPermissionState(
      requestOption: p.PermissionRequestOption(
        iosAccessLevel: p.IosAccessLevel.readWrite,
        androidPermission: p.AndroidPermission(type: p.RequestType.common, mediaLocation: false),
      ),
    ).then(fromPhotoStatus);
  }

  Future<PermissionStatus> requestLocationPermission() async {
    final status = await locationStatus();

    if (status == PermissionStatus.granted) {
      return status;
    }

    final res = await l.Location().requestPermission();
    return fromLocationStatus(res);
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
