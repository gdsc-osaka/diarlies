import 'package:api/api.dart';

extension DateTimeExt on DateTime {
  Date toDate() {
    return Date(year, month, day);
  }
}
