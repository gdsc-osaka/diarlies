import 'dart:async';

import 'package:api/api.dart';
import 'package:diarlies/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as f;

import 'api_providers.dart';
import 'firebase_providers.dart';

part 'auth_providers.g.dart';

typedef AuthUser = f.User;

@Riverpod(keepAlive: true)
class CurrentAuthUser extends _$CurrentAuthUser {
  @override
  Stream<AuthUser?> build() {
    try {
      return ref.watch(authProvider).authStateChanges();
    } on f.FirebaseAuthException catch (e) {
      if (e.code == 'core/no-app') {
        logger.i('[CurrentAuthUser] $e');
        return Stream.value(null);
      }
      return Stream.value(null);
    }
  }

  void setUser(AuthUser? user) {
    state = AsyncValue.data(user);
  }
}

class AuthUninitializedException implements Exception {
  @override
  String toString() => 'Firebase Auth is not initialized. Please initialize Firebase before using this provider.';
}

@Riverpod(keepAlive: true)
Stream<String?> currentIdToken(Ref ref) {
  final controller = StreamController<String?>();

  ref.listen(currentAuthUserProvider, (prev, next) async {
    final user = next.valueOrNull;
    if (user == null) {
      controller.add(null);
      return;
    }

    try {
      final token = await user.getIdToken();
      logger.d('[CurrentIdToken] idToken: ${token?.substring(0, 10)}...');
      controller.add(token);
    } catch (e, s) {
      logger.e('[CurrentIdToken] Error getting ID token', error: e, stackTrace: s);
      controller.addError(e, s);
    }
  });

  controller.addError(AuthUninitializedException());

  return controller.stream;
}


@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  Future<User?> build() async {
    if (Firebase.apps.isEmpty) throw AuthUninitializedException();

    final res = await ref.watch(usersApiProvider).getUser();
    return res.data;
  }

  void setUser(User user) {
    state = AsyncValue.data(user);
  }

  void clearUser() {
    state = const AsyncValue<User?>.loading();
  }
}

enum AuthEvent { signedIn, signedOut, reloaded, signedInWithAnotherAccount, unauthenticated, uninitialized }

@Riverpod(keepAlive: true)
Stream<AuthEvent> authEvent(Ref ref) {
  final controller = StreamController<AuthEvent>();
  controller.add(AuthEvent.uninitialized);
  AuthEvent oldState = AuthEvent.uninitialized;

  ref.listen(
    currentUserProvider,
    (prevUser, user) async {
      final isLoading = user.isLoading;
      final userNotFound = user.hasValue && user.value == null;
      final userExists = user.hasValue && user.value != null;
      final failedToAuthenticate = user.hasError && user.error is! AuthUninitializedException;

      logger.d('[AuthEvent], ${prevUser?.valueOrNull}, ${user.valueOrNull}');

      final newState = switch (oldState) {
        AuthEvent.uninitialized => switch (true) {
          _ when isLoading => AuthEvent.uninitialized,
          _ when userNotFound || failedToAuthenticate => AuthEvent.unauthenticated,
          _ when userExists => AuthEvent.signedIn,
          _ => AuthEvent.uninitialized,
        },
        AuthEvent.signedIn => switch (true) {
          _ when userNotFound || failedToAuthenticate => AuthEvent.signedOut,
          _ => AuthEvent.signedIn,
        },
        AuthEvent.signedOut => switch (true) {
          _ when userExists => AuthEvent.signedIn,
          _ => AuthEvent.signedOut,
        },
        AuthEvent.reloaded => switch (true) {
          _ when userNotFound || failedToAuthenticate => AuthEvent.signedOut,
          _ when userExists => AuthEvent.signedIn,
          _ => AuthEvent.reloaded,
        },
        AuthEvent.signedInWithAnotherAccount => switch (true) {
          _ when isLoading => AuthEvent.signedInWithAnotherAccount,
          _ when userNotFound || failedToAuthenticate => AuthEvent.signedOut,
          _ when userExists => AuthEvent.signedIn,
          _ => AuthEvent.signedInWithAnotherAccount,
        },
        AuthEvent.unauthenticated => switch (true) {
          _ when userExists => AuthEvent.signedIn,
          _ => AuthEvent.unauthenticated,
        },
      };

      if (oldState == newState) return;
      logger.i(
        '[AuthEvent] oldState: $oldState, newState: $newState',
      );

      controller.add(newState);
      oldState = newState;

      // if (userNotFound && prevUser != null && prevUser.hasValue) {
      //   return controller.add(AuthEvent.signedOut);
      // }
      //
      // if (userExists && (prevUser == null || prevUser.isLoading)) {
      //   return controller.add(AuthEvent.signedIn);
      // }
      //
      // // if (userExists && prevUser != null && prevUser.value != null && user.value!.id == prevUser.value!.id) {
      // //   return controller.add(AuthEvent.reloaded);
      // // }
      //
      // if (userExists && prevUser != null && prevUser.value != null && user.value!.id != prevUser.value!.id) {
      //   return controller.add(AuthEvent.signedInWithAnotherAccount);
      // }
      //
      // controller.add(AuthEvent.unauthenticated);
    },
    onError: (err, stack) {
      controller.addError(err, stack);
    },
  );

  return controller.stream;
}
