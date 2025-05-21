// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_inappropriate_diary_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReportInappropriateDiaryRequest
    extends ReportInappropriateDiaryRequest {
  @override
  final String reason;

  factory _$ReportInappropriateDiaryRequest(
          [void Function(ReportInappropriateDiaryRequestBuilder)? updates]) =>
      (new ReportInappropriateDiaryRequestBuilder()..update(updates))._build();

  _$ReportInappropriateDiaryRequest._({required this.reason}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        reason, r'ReportInappropriateDiaryRequest', 'reason');
  }

  @override
  ReportInappropriateDiaryRequest rebuild(
          void Function(ReportInappropriateDiaryRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReportInappropriateDiaryRequestBuilder toBuilder() =>
      new ReportInappropriateDiaryRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportInappropriateDiaryRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReportInappropriateDiaryRequest')
          ..add('reason', reason))
        .toString();
  }
}

class ReportInappropriateDiaryRequestBuilder
    implements
        Builder<ReportInappropriateDiaryRequest,
            ReportInappropriateDiaryRequestBuilder> {
  _$ReportInappropriateDiaryRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  ReportInappropriateDiaryRequestBuilder() {
    ReportInappropriateDiaryRequest._defaults(this);
  }

  ReportInappropriateDiaryRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportInappropriateDiaryRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReportInappropriateDiaryRequest;
  }

  @override
  void update(void Function(ReportInappropriateDiaryRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReportInappropriateDiaryRequest build() => _build();

  _$ReportInappropriateDiaryRequest _build() {
    final _$result = _$v ??
        new _$ReportInappropriateDiaryRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'ReportInappropriateDiaryRequest', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
