// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Day extends Day {
  @override
  final int year;
  @override
  final int month;
  @override
  final int day;

  factory _$Day([void Function(DayBuilder)? updates]) =>
      (new DayBuilder()..update(updates))._build();

  _$Day._({required this.year, required this.month, required this.day})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(year, r'Day', 'year');
    BuiltValueNullFieldError.checkNotNull(month, r'Day', 'month');
    BuiltValueNullFieldError.checkNotNull(day, r'Day', 'day');
  }

  @override
  Day rebuild(void Function(DayBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DayBuilder toBuilder() => new DayBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Day &&
        year == other.year &&
        month == other.month &&
        day == other.day;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, day.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Day')
          ..add('year', year)
          ..add('month', month)
          ..add('day', day))
        .toString();
  }
}

class DayBuilder implements Builder<Day, DayBuilder> {
  _$Day? _$v;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  int? _month;
  int? get month => _$this._month;
  set month(int? month) => _$this._month = month;

  int? _day;
  int? get day => _$this._day;
  set day(int? day) => _$this._day = day;

  DayBuilder() {
    Day._defaults(this);
  }

  DayBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _year = $v.year;
      _month = $v.month;
      _day = $v.day;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Day other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Day;
  }

  @override
  void update(void Function(DayBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Day build() => _build();

  _$Day _build() {
    final _$result = _$v ??
        new _$Day._(
          year: BuiltValueNullFieldError.checkNotNull(year, r'Day', 'year'),
          month: BuiltValueNullFieldError.checkNotNull(month, r'Day', 'month'),
          day: BuiltValueNullFieldError.checkNotNull(day, r'Day', 'day'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
