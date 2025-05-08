part of 'page.dart';

@riverpod
OnboardingAction _onboardingAction(Ref ref) => OnboardingAction(ref);

class OnboardingAction extends FluxAction {
  OnboardingAction(super.ref);

  void next() {
    ref.read(routerProvider).pushNamed(OnboardingPermissionPage.name);
  }

  void setLanguage(Language? language) {
    if (language == null) return;

    ref.read(diaryLanguageProvider.notifier).setLanguage(language);
  }
}