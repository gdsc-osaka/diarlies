import 'package:hive/hive.dart';

part 'location_point.g.dart';

@HiveType(typeId: 0)
class LocationPoint extends HiveObject {
  @HiveField(0)
  late DateTime createdAt;

  @HiveField(1)
  late double lat;

  @HiveField(2)
  late double lng;

  LocationPoint({required this.createdAt, required this.lat, required this.lng});

  @override
  String toString() {
    return 'LocationPoint(createdAt: $createdAt, lat: $lat, lng: $lng)';
  }
}
