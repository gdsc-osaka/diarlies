// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ServiceError extends ServiceError {
  @override
  final int status;
  @override
  final String message;
  @override
  final String? code;
  @override
  final BuiltMap<String, JsonObject?>? extra;

  factory _$ServiceError([void Function(ServiceErrorBuilder)? updates]) =>
      (new ServiceErrorBuilder()..update(updates))._build();

  _$ServiceError._(
      {required this.status, required this.message, this.code, this.extra})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, r'ServiceError', 'status');
    BuiltValueNullFieldError.checkNotNull(message, r'ServiceError', 'message');
  }

  @override
  ServiceError rebuild(void Function(ServiceErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ServiceErrorBuilder toBuilder() => new ServiceErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServiceError &&
        status == other.status &&
        message == other.message &&
        code == other.code &&
        extra == other.extra;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, extra.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ServiceError')
          ..add('status', status)
          ..add('message', message)
          ..add('code', code)
          ..add('extra', extra))
        .toString();
  }
}

class ServiceErrorBuilder
    implements Builder<ServiceError, ServiceErrorBuilder> {
  _$ServiceError? _$v;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  MapBuilder<String, JsonObject?>? _extra;
  MapBuilder<String, JsonObject?> get extra =>
      _$this._extra ??= new MapBuilder<String, JsonObject?>();
  set extra(MapBuilder<String, JsonObject?>? extra) => _$this._extra = extra;

  ServiceErrorBuilder() {
    ServiceError._defaults(this);
  }

  ServiceErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _message = $v.message;
      _code = $v.code;
      _extra = $v.extra?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServiceError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ServiceError;
  }

  @override
  void update(void Function(ServiceErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ServiceError build() => _build();

  _$ServiceError _build() {
    _$ServiceError _$result;
    try {
      _$result = _$v ??
          new _$ServiceError._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'ServiceError', 'status'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'ServiceError', 'message'),
            code: code,
            extra: _extra?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'extra';
        _extra?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ServiceError', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
