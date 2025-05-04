import 'package:diarlies/pages/splash/page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(initialLocation: '/', routes: [GoRoute(path: '/', builder: (context, state) => const SplashPage())]);
}
