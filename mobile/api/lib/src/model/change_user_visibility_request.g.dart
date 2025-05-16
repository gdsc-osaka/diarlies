// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_user_visibility_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangeUserVisibilityRequest extends ChangeUserVisibilityRequest {
  @override
  final AccountVisibility visibility;

  factory _$ChangeUserVisibilityRequest(
          [void Function(ChangeUserVisibilityRequestBuilder)? updates]) =>
      (new ChangeUserVisibilityRequestBuilder()..update(updates))._build();

  _$ChangeUserVisibilityRequest._({required this.visibility}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        visibility, r'ChangeUserVisibilityRequest', 'visibility');
  }

  @override
  ChangeUserVisibilityRequest rebuild(
          void Function(ChangeUserVisibilityRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangeUserVisibilityRequestBuilder toBuilder() =>
      new ChangeUserVisibilityRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeUserVisibilityRequest &&
        visibility == other.visibility;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, visibility.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangeUserVisibilityRequest')
          ..add('visibility', visibility))
        .toString();
  }
}

class ChangeUserVisibilityRequestBuilder
    implements
        Builder<ChangeUserVisibilityRequest,
            ChangeUserVisibilityRequestBuilder> {
  _$ChangeUserVisibilityRequest? _$v;

  AccountVisibility? _visibility;
  AccountVisibility? get visibility => _$this._visibility;
  set visibility(AccountVisibility? visibility) =>
      _$this._visibility = visibility;

  ChangeUserVisibilityRequestBuilder() {
    ChangeUserVisibilityRequest._defaults(this);
  }

  ChangeUserVisibilityRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _visibility = $v.visibility;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeUserVisibilityRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChangeUserVisibilityRequest;
  }

  @override
  void update(void Function(ChangeUserVisibilityRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeUserVisibilityRequest build() => _build();

  _$ChangeUserVisibilityRequest _build() {
    final _$result = _$v ??
        new _$ChangeUserVisibilityRequest._(
          visibility: BuiltValueNullFieldError.checkNotNull(
              visibility, r'ChangeUserVisibilityRequest', 'visibility'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
