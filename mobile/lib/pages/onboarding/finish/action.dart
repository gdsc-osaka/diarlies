part of 'page.dart';

@riverpod
OnboardingFinishAction _onboardingFinishAction(Ref ref) => OnboardingFinishAction(ref);

class OnboardingFinishAction extends FluxAction {
  OnboardingFinishAction(super.ref);

  void start() async {
    final prefService = await ref.read(preferencesServiceProvider.future);
    await prefService.setOnboardingCompleted(true);
    ref.read(routerProvider).goNamed(HomePage.name);
  }
}