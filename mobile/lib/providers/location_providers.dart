import 'package:diarlies/services/api_adapter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/location_storage_service.dart';

part 'location_providers.g.dart';

@riverpod
LocationStorageService locationStorageService(Ref ref) => LocationStorageService();

@riverpod
List<LocationHistory> storedLocationHistories(Ref ref) {
  final service = ref.watch(locationStorageServiceProvider);
  final locationPoints = service.getAllLocationPoints();
  return locationPoints
      .map((point) => LocationHistory(visitedAt: point.createdAt, lat: point.lat, lng: point.lng))
      .toList();
}
