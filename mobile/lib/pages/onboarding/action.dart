part of 'page.dart';

@riverpod
OnboardingAction _onboardingAction(Ref ref) => OnboardingAction(ref);

class OnboardingAction extends FluxAction {
  OnboardingAction(super.ref);

  Future<void> next() async {
    final permissionAllGranted = await ref.read(isPermissionAllGrantedProvider.future);

    if (permissionAllGranted) {
      ref.read(routerProvider).pushNamed(OnboardingFinishPage.name);
    } else {
      ref.read(routerProvider).pushNamed(OnboardingPermissionPage.name);
    }
  }

  Future<void> setLanguage(Language? language) async {
    if (language == null) return;

    await ref.read(diaryLanguageProvider.notifier).setLanguage(language);
  }
}