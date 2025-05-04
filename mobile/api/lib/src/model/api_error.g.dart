// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiError extends ApiError {
  @override
  final String code;
  @override
  final String message;

  factory _$ApiError([void Function(ApiErrorBuilder)? updates]) =>
      (new ApiErrorBuilder()..update(updates))._build();

  _$ApiError._({required this.code, required this.message}) : super._() {
    BuiltValueNullFieldError.checkNotNull(code, r'ApiError', 'code');
    BuiltValueNullFieldError.checkNotNull(message, r'ApiError', 'message');
  }

  @override
  ApiError rebuild(void Function(ApiErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApiErrorBuilder toBuilder() => new ApiErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiError && code == other.code && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiError')
          ..add('code', code)
          ..add('message', message))
        .toString();
  }
}

class ApiErrorBuilder implements Builder<ApiError, ApiErrorBuilder> {
  _$ApiError? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ApiErrorBuilder() {
    ApiError._defaults(this);
  }

  ApiErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ApiError;
  }

  @override
  void update(void Function(ApiErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiError build() => _build();

  _$ApiError _build() {
    final _$result = _$v ??
        new _$ApiError._(
          code:
              BuiltValueNullFieldError.checkNotNull(code, r'ApiError', 'code'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'ApiError', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
