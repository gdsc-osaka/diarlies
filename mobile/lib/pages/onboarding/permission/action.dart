part of 'page.dart';

@riverpod
OnboardingPermissionAction _onboardingPermissionAction(Ref ref) => OnboardingPermissionAction(ref);

class OnboardingPermissionAction extends FluxAction {
  OnboardingPermissionAction(super.ref);

  Future<void> requestPermission() async {
    final permissionService = ref.read(permissionServiceProvider);

    if (ref.read(locationPermissionProvider).valueOrNull != PermissionStatus.granted) {
      await permissionService.requestLocationPermission();
    }
    if (ref.read(notificationPermissionProvider).valueOrNull != PermissionStatus.granted) {
      await permissionService.requestNotificationPermission();
    }

    if (ref.read(notificationPermissionProvider).valueOrNull == PermissionStatus.granted) {
      await permissionService.requestNotificationPermission();
    }

    // reload
    ref.invalidate(permissionServiceProvider);
  }

  void back() {
    ref.read(routerProvider).pop();
  }

  void finish() {
    ref.read(routerProvider).goNamed(OnboardingFinishPage.name);
  }
}
