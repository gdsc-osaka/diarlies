part of 'page.dart';

@riverpod
OnboardingFinishAction _onboardingFinishAction(Ref ref) => OnboardingFinishAction(ref);

class OnboardingFinishAction extends FluxAction {
  OnboardingFinishAction(super.ref);

  void start() {
    ref.read(routerProvider).goNamed(HomePage.name);
  }
}