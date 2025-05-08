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

  ref.listen(
    currentUserProvider,
    (prevUser, user) {
      final userNotFound = user.hasValue && user.value == null;
      final userExists = user.hasValue && user.value != null;

      if (userNotFound && prevUser != null && prevUser.hasValue) {
        return controller.add(AuthEvent.signedOut);
      }

      if (userExists && (prevUser == null || prevUser.isLoading)) {
        return controller.add(AuthEvent.signedIn);
      }

      // if (userExists && prevUser != null && prevUser.value != null && user.value!.id == prevUser.value!.id) {
      //   return controller.add(AuthEvent.reloaded);
      // }

      if (userExists && prevUser != null && prevUser.value != null && user.value!.id != prevUser.value!.id) {
        return controller.add(AuthEvent.signedInWithAnotherAccount);
      }

      if (userNotFound) {
        return controller.add(AuthEvent.unauthenticated);
      }
    },
    onError: (err, stack) {
      controller.addError(err, stack);
    },
  );

  return controller.stream;
}
