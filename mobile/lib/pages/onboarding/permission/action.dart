part of 'page.dart';

@riverpod
OnboardingPermissionAction _onboardingPermissionAction(Ref ref) => OnboardingPermissionAction(ref);

class OnboardingPermissionAction extends FluxAction {
  OnboardingPermissionAction(super.ref);

  void configurePermission() {

  }

  void back() {
    ref.read(routerProvider).pop();
  }

  void finish() {
  }
}