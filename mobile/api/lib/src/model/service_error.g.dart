// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ServiceErrorBrandEnum _$serviceErrorBrandEnum_serviceError =
    const ServiceErrorBrandEnum._('serviceError');

ServiceErrorBrandEnum _$serviceErrorBrandEnumValueOf(String name) {
  switch (name) {
    case 'serviceError':
      return _$serviceErrorBrandEnum_serviceError;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ServiceErrorBrandEnum> _$serviceErrorBrandEnumValues =
    new BuiltSet<ServiceErrorBrandEnum>(const <ServiceErrorBrandEnum>[
  _$serviceErrorBrandEnum_serviceError,
]);

Serializer<ServiceErrorBrandEnum> _$serviceErrorBrandEnumSerializer =
    new _$ServiceErrorBrandEnumSerializer();

class _$ServiceErrorBrandEnumSerializer
    implements PrimitiveSerializer<ServiceErrorBrandEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'serviceError': 'ServiceError',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ServiceError': 'serviceError',
  };

  @override
  final Iterable<Type> types = const <Type>[ServiceErrorBrandEnum];
  @override
  final String wireName = 'ServiceErrorBrandEnum';

  @override
  Object serialize(Serializers serializers, ServiceErrorBrandEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ServiceErrorBrandEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ServiceErrorBrandEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ServiceError extends ServiceError {
  @override
  final int status;
  @override
  final String message;
  @override
  final String? code;
  @override
  final ServiceErrorBrandEnum brand;

  factory _$ServiceError([void Function(ServiceErrorBuilder)? updates]) =>
      (new ServiceErrorBuilder()..update(updates))._build();

  _$ServiceError._(
      {required this.status,
      required this.message,
      this.code,
      required this.brand})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, r'ServiceError', 'status');
    BuiltValueNullFieldError.checkNotNull(message, r'ServiceError', 'message');
    BuiltValueNullFieldError.checkNotNull(brand, r'ServiceError', 'brand');
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
        brand == other.brand;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ServiceError')
          ..add('status', status)
          ..add('message', message)
          ..add('code', code)
          ..add('brand', brand))
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

  ServiceErrorBrandEnum? _brand;
  ServiceErrorBrandEnum? get brand => _$this._brand;
  set brand(ServiceErrorBrandEnum? brand) => _$this._brand = brand;

  ServiceErrorBuilder() {
    ServiceError._defaults(this);
  }

  ServiceErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _message = $v.message;
      _code = $v.code;
      _brand = $v.brand;
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
    final _$result = _$v ??
        new _$ServiceError._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'ServiceError', 'status'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'ServiceError', 'message'),
          code: code,
          brand: BuiltValueNullFieldError.checkNotNull(
              brand, r'ServiceError', 'brand'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
