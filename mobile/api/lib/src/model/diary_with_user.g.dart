// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_with_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DiaryWithUser extends DiaryWithUser {
  @override
  final User user;
  @override
  final String id;
  @override
  final String content;
  @override
  final Day diaryDate;
  @override
  final String thumbnailUrl;
  @override
  final Timestamp createdAt;
  @override
  final Timestamp updatedAt;

  factory _$DiaryWithUser([void Function(DiaryWithUserBuilder)? updates]) =>
      (new DiaryWithUserBuilder()..update(updates))._build();

  _$DiaryWithUser._(
      {required this.user,
      required this.id,
      required this.content,
      required this.diaryDate,
      required this.thumbnailUrl,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(user, r'DiaryWithUser', 'user');
    BuiltValueNullFieldError.checkNotNull(id, r'DiaryWithUser', 'id');
    BuiltValueNullFieldError.checkNotNull(content, r'DiaryWithUser', 'content');
    BuiltValueNullFieldError.checkNotNull(
        diaryDate, r'DiaryWithUser', 'diaryDate');
    BuiltValueNullFieldError.checkNotNull(
        thumbnailUrl, r'DiaryWithUser', 'thumbnailUrl');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'DiaryWithUser', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'DiaryWithUser', 'updatedAt');
  }

  @override
  DiaryWithUser rebuild(void Function(DiaryWithUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiaryWithUserBuilder toBuilder() => new DiaryWithUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DiaryWithUser &&
        user == other.user &&
        id == other.id &&
        content == other.content &&
        diaryDate == other.diaryDate &&
        thumbnailUrl == other.thumbnailUrl &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, diaryDate.hashCode);
    _$hash = $jc(_$hash, thumbnailUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DiaryWithUser')
          ..add('user', user)
          ..add('id', id)
          ..add('content', content)
          ..add('diaryDate', diaryDate)
          ..add('thumbnailUrl', thumbnailUrl)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class DiaryWithUserBuilder
    implements Builder<DiaryWithUser, DiaryWithUserBuilder>, DiaryBuilder {
  _$DiaryWithUser? _$v;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(covariant UserBuilder? user) => _$this._user = user;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _content;
  String? get content => _$this._content;
  set content(covariant String? content) => _$this._content = content;

  DayBuilder? _diaryDate;
  DayBuilder get diaryDate => _$this._diaryDate ??= new DayBuilder();
  set diaryDate(covariant DayBuilder? diaryDate) =>
      _$this._diaryDate = diaryDate;

  String? _thumbnailUrl;
  String? get thumbnailUrl => _$this._thumbnailUrl;
  set thumbnailUrl(covariant String? thumbnailUrl) =>
      _$this._thumbnailUrl = thumbnailUrl;

  TimestampBuilder? _createdAt;
  TimestampBuilder get createdAt =>
      _$this._createdAt ??= new TimestampBuilder();
  set createdAt(covariant TimestampBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  TimestampBuilder? _updatedAt;
  TimestampBuilder get updatedAt =>
      _$this._updatedAt ??= new TimestampBuilder();
  set updatedAt(covariant TimestampBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  DiaryWithUserBuilder() {
    DiaryWithUser._defaults(this);
  }

  DiaryWithUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user.toBuilder();
      _id = $v.id;
      _content = $v.content;
      _diaryDate = $v.diaryDate.toBuilder();
      _thumbnailUrl = $v.thumbnailUrl;
      _createdAt = $v.createdAt.toBuilder();
      _updatedAt = $v.updatedAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant DiaryWithUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DiaryWithUser;
  }

  @override
  void update(void Function(DiaryWithUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DiaryWithUser build() => _build();

  _$DiaryWithUser _build() {
    _$DiaryWithUser _$result;
    try {
      _$result = _$v ??
          new _$DiaryWithUser._(
            user: user.build(),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'DiaryWithUser', 'id'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'DiaryWithUser', 'content'),
            diaryDate: diaryDate.build(),
            thumbnailUrl: BuiltValueNullFieldError.checkNotNull(
                thumbnailUrl, r'DiaryWithUser', 'thumbnailUrl'),
            createdAt: createdAt.build(),
            updatedAt: updatedAt.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();

        _$failedField = 'diaryDate';
        diaryDate.build();

        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'updatedAt';
        updatedAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DiaryWithUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
