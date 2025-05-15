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

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  Future<User?> build() async {
    if (Firebase.apps.isEmpty) return Future.error('uninitialized');

    final res = await ref.watch(usersApiProvider).getUsers();
    return res.data;
  }

  void setUser(User user) {
    state = AsyncValue.data(user);
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
      final failedToAuthenticate = user.hasError && user.error != 'uninitialized';

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
