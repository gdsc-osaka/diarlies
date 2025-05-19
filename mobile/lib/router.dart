import 'package:diarlies/pages/home/layout.dart';
import 'package:diarlies/pages/home/page.dart';
import 'package:diarlies/pages/home/settings/page.dart';
import 'package:diarlies/pages/home/social/page.dart';
import 'package:diarlies/pages/onboarding/finish/page.dart';
import 'package:diarlies/pages/onboarding/page.dart';
import 'package:diarlies/pages/onboarding/permission/page.dart';
import 'package:diarlies/pages/signup/page.dart';
import 'package:diarlies/pages/splash/page.dart';
import 'package:diarlies/services/preferences_service.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/transition_builders.dart';
import 'providers/auth_providers.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final router = GoRouter(
    initialLocation: SplashPage.path,
    routes: [
      GoRoute(path: SplashPage.path, name: SplashPage.name, builder: (context, state) => const SplashPage()),
      GoRoute(
        path: SignupPage.path,
        name: SignupPage.name,
        pageBuilder:
            (context, state) => const CustomTransitionPage(
              child: SignupPage(),
              transitionsBuilder: TransitionBuilders.fadeIn,
              transitionDuration: Duration(milliseconds: 300),
            ),
      ),
      GoRoute(
        path: OnboardingPage.path,
        name: OnboardingPage.name,
        pageBuilder:
            (context, state) => const CustomTransitionPage(
              child: OnboardingPage(),
              transitionsBuilder: TransitionBuilders.fadeIn,
              transitionDuration: Duration(milliseconds: 300),
            ),
        routes: [
          GoRoute(
            path: OnboardingPermissionPage.path,
            name: OnboardingPermissionPage.name,
            builder: (context, state) => const OnboardingPermissionPage(),
          ),
          GoRoute(
            path: OnboardingFinishPage.path,
            name: OnboardingFinishPage.name,
            builder: (context, state) => const OnboardingFinishPage(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder:
            (context, state, shell) =>
                CustomTransitionPage(child: HomeLayout(shell: shell), transitionsBuilder: TransitionBuilders.fadeIn),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: HomePage.path, name: HomePage.name, builder: (context, state) => HomePage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: HomeSocialPage.path, name: HomeSocialPage.name, builder: (context, state) => HomeSocialPage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: HomeSettingsPage.path, name: HomeSettingsPage.name, builder: (context, state) => HomeSettingsPage()),
            ],
          ),
        ],
      ),
    ],
  );

  ref.listen(authEventProvider, (prev, next) async {
    final onboardingCompleted = await ref.read(onboardingCompletedProvider.future);

    if (next.value == AuthEvent.signedIn) {
      router.goNamed(onboardingCompleted ? HomePage.name :OnboardingPage.name);
      return;
    }

    if (next.value == AuthEvent.signedOut || next.value == AuthEvent.unauthenticated) {
      router.goNamed(SignupPage.name);
      return;
    }
  });

  return router;
}
