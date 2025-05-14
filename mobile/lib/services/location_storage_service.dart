import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_model/hive_model.dart';

class LocationStorageService {
  static const String _locationBoxName = 'locationPoints';

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LocationPointAdapter()); // 生成されたアダプタを登録
    await Hive.openBox<LocationPoint>(_locationBoxName);
  }

  Box<LocationPoint> get _locationBox => Hive.box<LocationPoint>(_locationBoxName);

  Future<void> addLocationPoint(LocationPoint point) async {
    await _locationBox.add(point);
  }

  List<LocationPoint> getAllLocationPoints() {
    return _locationBox.values.toList();
  }

  LocationPoint? getLastLocationPoint() {
    if (_locationBox.isNotEmpty) {
      return _locationBox.values.last;
    }
    return null;
  }

  Future<void> clearAllLocationPoints() async {
    await _locationBox.clear();
  }
}