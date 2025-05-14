// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_adapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationHistory _$LocationHistoryFromJson(Map<String, dynamic> json) =>
    _LocationHistory(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      visitedAt: DateTime.parse(json['visitedAt'] as String),
    );

Map<String, dynamic> _$LocationHistoryToJson(_LocationHistory instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'visitedAt': instance.visitedAt.toIso8601String(),
    };
