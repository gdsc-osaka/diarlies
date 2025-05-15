// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$permissionServiceHash() => r'8944118369fdc2dd355a221dd4f8a487b7f3372c';

/// See also [permissionService].
@ProviderFor(permissionService)
final permissionServiceProvider =
    AutoDisposeProvider<PermissionService>.internal(
      permissionService,
      name: r'permissionServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$permissionServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PermissionServiceRef = AutoDisposeProviderRef<PermissionService>;
String _$locationPermissionHash() =>
    r'c100bf474ecddd6cbdb7fce9e9d20687089f67ff';

/// See also [locationPermission].
@ProviderFor(locationPermission)
final locationPermissionProvider =
    AutoDisposeFutureProvider<PermissionStatus>.internal(
      locationPermission,
      name: r'locationPermissionProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$locationPermissionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationPermissionRef = AutoDisposeFutureProviderRef<PermissionStatus>;
String _$photoPermissionHash() => r'edd4bc332e270102021456e22892782a70dfa82c';

/// See also [photoPermission].
@ProviderFor(photoPermission)
final photoPermissionProvider =
    AutoDisposeFutureProvider<PermissionStatus>.internal(
      photoPermission,
      name: r'photoPermissionProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$photoPermissionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PhotoPermissionRef = AutoDisposeFutureProviderRef<PermissionStatus>;
String _$notificationPermissionHash() =>
    r'484c02c34ad9857e23481ea3e7b85b9f4b4689eb';

/// See also [notificationPermission].
@ProviderFor(notificationPermission)
final notificationPermissionProvider =
    AutoDisposeFutureProvider<PermissionStatus>.internal(
      notificationPermission,
      name: r'notificationPermissionProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$notificationPermissionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationPermissionRef =
    AutoDisposeFutureProviderRef<PermissionStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
