import 'package:diarlies/logger.dart';
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
    final res = _locationBox.values.toList();
    final todays = res.where((point) => point.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 1)))).toList();
    final olds = res.where((point) => point.createdAt.isBefore(DateTime.now().subtract(const Duration(days: 1)))).toList();

    // 古いポイントを削除
    _locationBox.deleteAll(olds.map((point) => point.key));

    logger.d("Location points: $res");
    return todays;
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