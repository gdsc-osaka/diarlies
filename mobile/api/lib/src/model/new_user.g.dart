// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewUser extends NewUser {
  @override
  final String username;
  @override
  final String email;
  @override
  final String password;

  factory _$NewUser([void Function(NewUserBuilder)? updates]) =>
      (new NewUserBuilder()..update(updates))._build();

  _$NewUser._(
      {required this.username, required this.email, required this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(username, r'NewUser', 'username');
    BuiltValueNullFieldError.checkNotNull(email, r'NewUser', 'email');
    BuiltValueNullFieldError.checkNotNull(password, r'NewUser', 'password');
  }

  @override
  NewUser rebuild(void Function(NewUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewUserBuilder toBuilder() => new NewUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewUser &&
        username == other.username &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NewUser')
          ..add('username', username)
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class NewUserBuilder implements Builder<NewUser, NewUserBuilder> {
  _$NewUser? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  NewUserBuilder() {
    NewUser._defaults(this);
  }

  NewUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NewUser;
  }

  @override
  void update(void Function(NewUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NewUser build() => _build();

  _$NewUser _build() {
    final _$result = _$v ??
        new _$NewUser._(
          username: BuiltValueNullFieldError.checkNotNull(
              username, r'NewUser', 'username'),
          email:
              BuiltValueNullFieldError.checkNotNull(email, r'NewUser', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'NewUser', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
