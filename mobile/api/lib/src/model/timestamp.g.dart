// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timestamp.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Timestamp extends Timestamp {
  @override
  final int seconds;
  @override
  final int nanoseconds;

  factory _$Timestamp([void Function(TimestampBuilder)? updates]) =>
      (new TimestampBuilder()..update(updates))._build();

  _$Timestamp._({required this.seconds, required this.nanoseconds})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(seconds, r'Timestamp', 'seconds');
    BuiltValueNullFieldError.checkNotNull(
        nanoseconds, r'Timestamp', 'nanoseconds');
  }

  @override
  Timestamp rebuild(void Function(TimestampBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimestampBuilder toBuilder() => new TimestampBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Timestamp &&
        seconds == other.seconds &&
        nanoseconds == other.nanoseconds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, seconds.hashCode);
    _$hash = $jc(_$hash, nanoseconds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Timestamp')
          ..add('seconds', seconds)
          ..add('nanoseconds', nanoseconds))
        .toString();
  }
}

class TimestampBuilder implements Builder<Timestamp, TimestampBuilder> {
  _$Timestamp? _$v;

  int? _seconds;
  int? get seconds => _$this._seconds;
  set seconds(int? seconds) => _$this._seconds = seconds;

  int? _nanoseconds;
  int? get nanoseconds => _$this._nanoseconds;
  set nanoseconds(int? nanoseconds) => _$this._nanoseconds = nanoseconds;

  TimestampBuilder() {
    Timestamp._defaults(this);
  }

  TimestampBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _seconds = $v.seconds;
      _nanoseconds = $v.nanoseconds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Timestamp other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Timestamp;
  }

  @override
  void update(void Function(TimestampBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Timestamp build() => _build();

  _$Timestamp _build() {
    final _$result = _$v ??
        new _$Timestamp._(
          seconds: BuiltValueNullFieldError.checkNotNull(
              seconds, r'Timestamp', 'seconds'),
          nanoseconds: BuiltValueNullFieldError.checkNotNull(
              nanoseconds, r'Timestamp', 'nanoseconds'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
