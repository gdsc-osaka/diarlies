// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_adapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationHistory {

 double get lat; double get lng; DateTime get visitedAt;
/// Create a copy of LocationHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationHistoryCopyWith<LocationHistory> get copyWith => _$LocationHistoryCopyWithImpl<LocationHistory>(this as LocationHistory, _$identity);

  /// Serializes this LocationHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationHistory&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.visitedAt, visitedAt) || other.visitedAt == visitedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lng,visitedAt);

@override
String toString() {
  return 'LocationHistory(lat: $lat, lng: $lng, visitedAt: $visitedAt)';
}


}

/// @nodoc
abstract mixin class $LocationHistoryCopyWith<$Res>  {
  factory $LocationHistoryCopyWith(LocationHistory value, $Res Function(LocationHistory) _then) = _$LocationHistoryCopyWithImpl;
@useResult
$Res call({
 double lat, double lng, DateTime visitedAt
});




}
/// @nodoc
class _$LocationHistoryCopyWithImpl<$Res>
    implements $LocationHistoryCopyWith<$Res> {
  _$LocationHistoryCopyWithImpl(this._self, this._then);

  final LocationHistory _self;
  final $Res Function(LocationHistory) _then;

/// Create a copy of LocationHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,Object? visitedAt = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,visitedAt: null == visitedAt ? _self.visitedAt : visitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LocationHistory implements LocationHistory {
  const _LocationHistory({required this.lat, required this.lng, required this.visitedAt});
  factory _LocationHistory.fromJson(Map<String, dynamic> json) => _$LocationHistoryFromJson(json);

@override final  double lat;
@override final  double lng;
@override final  DateTime visitedAt;

/// Create a copy of LocationHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationHistoryCopyWith<_LocationHistory> get copyWith => __$LocationHistoryCopyWithImpl<_LocationHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationHistory&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.visitedAt, visitedAt) || other.visitedAt == visitedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lng,visitedAt);

@override
String toString() {
  return 'LocationHistory(lat: $lat, lng: $lng, visitedAt: $visitedAt)';
}


}

/// @nodoc
abstract mixin class _$LocationHistoryCopyWith<$Res> implements $LocationHistoryCopyWith<$Res> {
  factory _$LocationHistoryCopyWith(_LocationHistory value, $Res Function(_LocationHistory) _then) = __$LocationHistoryCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng, DateTime visitedAt
});




}
/// @nodoc
class __$LocationHistoryCopyWithImpl<$Res>
    implements _$LocationHistoryCopyWith<$Res> {
  __$LocationHistoryCopyWithImpl(this._self, this._then);

  final _LocationHistory _self;
  final $Res Function(_LocationHistory) _then;

/// Create a copy of LocationHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,Object? visitedAt = null,}) {
  return _then(_LocationHistory(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,visitedAt: null == visitedAt ? _self.visitedAt : visitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
