import 'dart:convert';

import 'package:api/api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_adapter.freezed.dart';

part 'api_adapter.g.dart';

@freezed
abstract class LocationHistory with _$LocationHistory {
  const factory LocationHistory({required double lat, required double lng, required DateTime visitedAt}) =
      _LocationHistory;

  factory LocationHistory.fromJson(Map<String, Object?> json) => _$LocationHistoryFromJson(json);
}

/// form-data などの型を付けられないエンドポイント用のラッパー

typedef PostDiarlies =
    Future<Response<Diary>> Function({
      required List<LocationHistory> locationHistories,
      required BuiltList<MultipartFile> images,
      required LanguageCode languageCode,
      CancelToken? cancelToken,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      ValidateStatus? validateStatus,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    });

PostDiarlies postDiaries(DiariesApi diariesApi) =>
    ({
      required List<LocationHistory> locationHistories,
      required BuiltList<MultipartFile> images,
      required LanguageCode languageCode,
      CancelToken? cancelToken,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      ValidateStatus? validateStatus,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }) => diariesApi.createDiary(
      locationHistories: jsonEncode(locationHistories.map((hist) => hist.toJson()).toList()),
      images: images,
      languageCode: languageCode,
      cancelToken: cancelToken,
      headers: headers,
      extra: extra,
      validateStatus: validateStatus,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
