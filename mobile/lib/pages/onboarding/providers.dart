part of 'page.dart';

@Riverpod(keepAlive: true)
class DiaryLanguage extends _$DiaryLanguage {
  @override
  Future<Language?> build() async {
    final pref = await ref.watch(preferencesServiceProvider.future);
    return pref.getDiaryLanguage();
  }

  Future<void> setLanguage(Language language) async {
    state = AsyncValue.data(language);

    final pref = await ref.watch(preferencesServiceProvider.future);
    await pref.setDiaryLanguage(language);
  }
}

@riverpod
Future<bool> isPermissionAllGranted(Ref ref) async {
  final permissionStatuses = await Future.wait([
    ref.watch(locationPermissionProvider.future),
    // ref.watch(photoPermissionProvider.future),
    ref.watch(notificationPermissionProvider.future),
  ]);

  return permissionStatuses.every((status) => status == PermissionStatus.granted);
}
