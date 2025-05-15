// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Diary extends Diary {
  @override
  final String id;
  @override
  final String content;
  @override
  final Day diaryDate;
  @override
  final Timestamp createdAt;
  @override
  final Timestamp updatedAt;

  factory _$Diary([void Function(DiaryBuilder)? updates]) =>
      (new DiaryBuilder()..update(updates))._build();

  _$Diary._(
      {required this.id,
      required this.content,
      required this.diaryDate,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Diary', 'id');
    BuiltValueNullFieldError.checkNotNull(content, r'Diary', 'content');
    BuiltValueNullFieldError.checkNotNull(diaryDate, r'Diary', 'diaryDate');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Diary', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(updatedAt, r'Diary', 'updatedAt');
  }

  @override
  Diary rebuild(void Function(DiaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiaryBuilder toBuilder() => new DiaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Diary &&
        id == other.id &&
        content == other.content &&
        diaryDate == other.diaryDate &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, diaryDate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Diary')
          ..add('id', id)
          ..add('content', content)
          ..add('diaryDate', diaryDate)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class DiaryBuilder implements Builder<Diary, DiaryBuilder> {
  _$Diary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DayBuilder? _diaryDate;
  DayBuilder get diaryDate => _$this._diaryDate ??= new DayBuilder();
  set diaryDate(DayBuilder? diaryDate) => _$this._diaryDate = diaryDate;

  TimestampBuilder? _createdAt;
  TimestampBuilder get createdAt =>
      _$this._createdAt ??= new TimestampBuilder();
  set createdAt(TimestampBuilder? createdAt) => _$this._createdAt = createdAt;

  TimestampBuilder? _updatedAt;
  TimestampBuilder get updatedAt =>
      _$this._updatedAt ??= new TimestampBuilder();
  set updatedAt(TimestampBuilder? updatedAt) => _$this._updatedAt = updatedAt;

  DiaryBuilder() {
    Diary._defaults(this);
  }

  DiaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _content = $v.content;
      _diaryDate = $v.diaryDate.toBuilder();
      _createdAt = $v.createdAt.toBuilder();
      _updatedAt = $v.updatedAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Diary other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Diary;
  }

  @override
  void update(void Function(DiaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Diary build() => _build();

  _$Diary _build() {
    _$Diary _$result;
    try {
      _$result = _$v ??
          new _$Diary._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Diary', 'id'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'Diary', 'content'),
            diaryDate: diaryDate.build(),
            createdAt: createdAt.build(),
            updatedAt: updatedAt.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'diaryDate';
        diaryDate.build();
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'updatedAt';
        updatedAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Diary', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
