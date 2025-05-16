// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_service_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateUserServiceErrorCodeEnum
    _$createUserServiceErrorCodeEnum_userAlreadyExists =
    const CreateUserServiceErrorCodeEnum._('userAlreadyExists');
const CreateUserServiceErrorCodeEnum _$createUserServiceErrorCodeEnum_unknown =
    const CreateUserServiceErrorCodeEnum._('unknown');

CreateUserServiceErrorCodeEnum _$createUserServiceErrorCodeEnumValueOf(
    String name) {
  switch (name) {
    case 'userAlreadyExists':
      return _$createUserServiceErrorCodeEnum_userAlreadyExists;
    case 'unknown':
      return _$createUserServiceErrorCodeEnum_unknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<CreateUserServiceErrorCodeEnum>
    _$createUserServiceErrorCodeEnumValues = new BuiltSet<
        CreateUserServiceErrorCodeEnum>(const <CreateUserServiceErrorCodeEnum>[
  _$createUserServiceErrorCodeEnum_userAlreadyExists,
  _$createUserServiceErrorCodeEnum_unknown,
]);

Serializer<CreateUserServiceErrorCodeEnum>
    _$createUserServiceErrorCodeEnumSerializer =
    new _$CreateUserServiceErrorCodeEnumSerializer();

class _$CreateUserServiceErrorCodeEnumSerializer
    implements PrimitiveSerializer<CreateUserServiceErrorCodeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'userAlreadyExists': 'user-already-exists',
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'user-already-exists': 'userAlreadyExists',
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateUserServiceErrorCodeEnum];
  @override
  final String wireName = 'CreateUserServiceErrorCodeEnum';

  @override
  Object serialize(
          Serializers serializers, CreateUserServiceErrorCodeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateUserServiceErrorCodeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateUserServiceErrorCodeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateUserServiceError extends CreateUserServiceError {
  @override
  final int status;
  @override
  final String message;
  @override
  final CreateUserServiceErrorCodeEnum? code;
  @override
  final BuiltMap<String, JsonObject?>? extra;
  @override
  final User? user;

  factory _$CreateUserServiceError(
          [void Function(CreateUserServiceErrorBuilder)? updates]) =>
      (new CreateUserServiceErrorBuilder()..update(updates))._build();

  _$CreateUserServiceError._(
      {required this.status,
      required this.message,
      this.code,
      this.extra,
      this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        status, r'CreateUserServiceError', 'status');
    BuiltValueNullFieldError.checkNotNull(
        message, r'CreateUserServiceError', 'message');
  }

  @override
  CreateUserServiceError rebuild(
          void Function(CreateUserServiceErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateUserServiceErrorBuilder toBuilder() =>
      new CreateUserServiceErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateUserServiceError &&
        status == other.status &&
        message == other.message &&
        code == other.code &&
        extra == other.extra &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, extra.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateUserServiceError')
          ..add('status', status)
          ..add('message', message)
          ..add('code', code)
          ..add('extra', extra)
          ..add('user', user))
        .toString();
  }
}

class CreateUserServiceErrorBuilder
    implements Builder<CreateUserServiceError, CreateUserServiceErrorBuilder> {
  _$CreateUserServiceError? _$v;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreateUserServiceErrorCodeEnum? _code;
  CreateUserServiceErrorCodeEnum? get code => _$this._code;
  set code(CreateUserServiceErrorCodeEnum? code) => _$this._code = code;

  MapBuilder<String, JsonObject?>? _extra;
  MapBuilder<String, JsonObject?> get extra =>
      _$this._extra ??= new MapBuilder<String, JsonObject?>();
  set extra(MapBuilder<String, JsonObject?>? extra) => _$this._extra = extra;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  CreateUserServiceErrorBuilder() {
    CreateUserServiceError._defaults(this);
  }

  CreateUserServiceErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _message = $v.message;
      _code = $v.code;
      _extra = $v.extra?.toBuilder();
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateUserServiceError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateUserServiceError;
  }

  @override
  void update(void Function(CreateUserServiceErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateUserServiceError build() => _build();

  _$CreateUserServiceError _build() {
    _$CreateUserServiceError _$result;
    try {
      _$result = _$v ??
          new _$CreateUserServiceError._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'CreateUserServiceError', 'status'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'CreateUserServiceError', 'message'),
            code: code,
            extra: _extra?.build(),
            user: _user?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'extra';
        _extra?.build();
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CreateUserServiceError', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
