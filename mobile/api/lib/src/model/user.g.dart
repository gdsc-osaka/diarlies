// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String id;
  @override
  final String uid;
  @override
  final AccountVisibility visibility;
  @override
  final String? iconUrl;
  @override
  final Timestamp createdAt;
  @override
  final Timestamp updatedAt;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates))._build();

  _$User._(
      {required this.id,
      required this.uid,
      required this.visibility,
      this.iconUrl,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'User', 'id');
    BuiltValueNullFieldError.checkNotNull(uid, r'User', 'uid');
    BuiltValueNullFieldError.checkNotNull(visibility, r'User', 'visibility');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'User', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(updatedAt, r'User', 'updatedAt');
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        uid == other.uid &&
        visibility == other.visibility &&
        iconUrl == other.iconUrl &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, visibility.hashCode);
    _$hash = $jc(_$hash, iconUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('id', id)
          ..add('uid', uid)
          ..add('visibility', visibility)
          ..add('iconUrl', iconUrl)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  AccountVisibility? _visibility;
  AccountVisibility? get visibility => _$this._visibility;
  set visibility(AccountVisibility? visibility) =>
      _$this._visibility = visibility;

  String? _iconUrl;
  String? get iconUrl => _$this._iconUrl;
  set iconUrl(String? iconUrl) => _$this._iconUrl = iconUrl;

  TimestampBuilder? _createdAt;
  TimestampBuilder get createdAt =>
      _$this._createdAt ??= new TimestampBuilder();
  set createdAt(TimestampBuilder? createdAt) => _$this._createdAt = createdAt;

  TimestampBuilder? _updatedAt;
  TimestampBuilder get updatedAt =>
      _$this._updatedAt ??= new TimestampBuilder();
  set updatedAt(TimestampBuilder? updatedAt) => _$this._updatedAt = updatedAt;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _uid = $v.uid;
      _visibility = $v.visibility;
      _iconUrl = $v.iconUrl;
      _createdAt = $v.createdAt.toBuilder();
      _updatedAt = $v.updatedAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'User', 'id'),
            uid: BuiltValueNullFieldError.checkNotNull(uid, r'User', 'uid'),
            visibility: BuiltValueNullFieldError.checkNotNull(
                visibility, r'User', 'visibility'),
            iconUrl: iconUrl,
            createdAt: createdAt.build(),
            updatedAt: updatedAt.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'updatedAt';
        updatedAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
