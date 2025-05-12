import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/permission_service.dart';

part 'permission_providers.g.dart';

@riverpod
PermissionService permissionService(Ref ref) {
  return PermissionService();
}

@riverpod
Future<PermissionStatus> locationPermission(Ref ref) {
  return ref.watch(permissionServiceProvider).locationStatus();
}

@riverpod
Future<PermissionStatus> photoPermission(Ref ref) {
  return ref.watch(permissionServiceProvider).photoStatus();
}
