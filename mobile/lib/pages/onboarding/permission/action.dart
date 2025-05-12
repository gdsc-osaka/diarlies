part of 'page.dart';

@riverpod
OnboardingPermissionAction _onboardingPermissionAction(Ref ref) => OnboardingPermissionAction(ref);

class OnboardingPermissionAction extends FluxAction {
  OnboardingPermissionAction(super.ref);

  Future<void> requestPermission() async {
    final permission = ref.read(permissionServiceProvider);
    final loc = await permission.requestLocationPermission();
    final photo = await permission.requestPhotoPermission();

    logger.d('[requestPermission] Location: $loc, Photo: $photo');

    // reload
    ref.invalidate(permissionServiceProvider);
  }

  void back() {
    ref.read(routerProvider).pop();
  }

  void finish() {
  }
}