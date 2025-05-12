part of 'page.dart';

@Riverpod(keepAlive: true)
class DiaryLanguage extends _$DiaryLanguage {
  @override
  Language? build() {
    return null;
  }

  void setLanguage(Language language) {
    state = language;
  }
}

@riverpod
Future<bool> isPermissionAllGranted(Ref ref) async {
  final permissionStatuses = await Future.wait([
    ref.watch(locationPermissionProvider.future),
    ref.watch(photoPermissionProvider.future)
  ]);

  return permissionStatuses.every((status) => status == PermissionStatus.granted);
}
