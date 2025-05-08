import 'package:diarlies/logger.dart';
import 'package:diarlies/pages/onboarding/page.dart';
import 'package:diarlies/pages/onboarding/permission/page.dart';
import 'package:diarlies/pages/signup/page.dart';
import 'package:diarlies/pages/splash/page.dart';
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
      GoRoute(path: SignupPage.path, name: SignupPage.name, builder: (context, state) => const SignupPage()),
      GoRoute(
        path: OnboardingPage.path,
        name: OnboardingPage.name,
        // builder: (context, state) => const OnboardingPage(),
        pageBuilder: (context, state) => const CustomTransitionPage(
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
        ],
      ),
    ],
  );

  ref.listen(authEventProvider, (prev, next) async {
    logger.d('[AuthEvent changed] prev: $prev, next: $next');
    if (next.value == AuthEvent.signedIn) {
      router.goNamed(OnboardingPage.name);
      return;
    }

    if (next.value == AuthEvent.signedOut || next.value == AuthEvent.unauthenticated) {
      router.goNamed(SignupPage.name);
      return;
    }
  });

  return router;
}
