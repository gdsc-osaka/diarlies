// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authEventHash() => r'abf2c42afd449c6ea3d4a9c35a337543c8d9e8a4';

/// See also [authEvent].
@ProviderFor(authEvent)
final authEventProvider = StreamProvider<AuthEvent>.internal(
  authEvent,
  name: r'authEventProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authEventHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthEventRef = StreamProviderRef<AuthEvent>;
String _$currentAuthUserHash() => r'd10b2cabf767546783fe9390e0cdc56d4295b095';

/// See also [CurrentAuthUser].
@ProviderFor(CurrentAuthUser)
final currentAuthUserProvider =
    StreamNotifierProvider<CurrentAuthUser, AuthUser?>.internal(
      CurrentAuthUser.new,
      name: r'currentAuthUserProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentAuthUserHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentAuthUser = StreamNotifier<AuthUser?>;
String _$currentUserHash() => r'a50b618e1db16bc8efe6fe79eeea243f10105ca1';

/// See also [CurrentUser].
@ProviderFor(CurrentUser)
final currentUserProvider = AsyncNotifierProvider<CurrentUser, User?>.internal(
  CurrentUser.new,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentUser = AsyncNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
