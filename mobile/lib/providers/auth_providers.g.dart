// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentIdTokenHash() => r'4f5986f86184e80e0b93953fef3d9a2cf09d85b2';

/// See also [currentIdToken].
@ProviderFor(currentIdToken)
final currentIdTokenProvider = StreamProvider<String?>.internal(
  currentIdToken,
  name: r'currentIdTokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentIdTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentIdTokenRef = StreamProviderRef<String?>;
String _$authEventHash() => r'5320e151432bacd28a5f21daf0b4c5151d327228';

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
String _$currentUserHash() => r'2dd76997388c4e51e4c7e125b2b04c9f98bdd58f';

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
