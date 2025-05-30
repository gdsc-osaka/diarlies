import 'dart:io';

import 'package:api/api.dart';
import 'package:diarlies/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../env.dart';
import 'auth_providers.dart';

part 'api_providers.g.dart';

@Riverpod(keepAlive: true)
Api api(Ref ref) {
  final api = Api(
    dio: Dio(BaseOptions(
      baseUrl: switch (isDebug) {
        true => Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://localhost:8080',
        _ => Api.basePath,
      },
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 30000),
    )),
    interceptors: [BearerAuthInterceptor(), LoggingInterceptor()],
  );

  final idToken = ref.watch(currentIdTokenProvider).value;
  if (idToken != null) {
    logger.d('idToken: ${idToken.substring(0, 10)}...');
    api.setBearerAuth('bearerAuth', idToken);
  }

  return api;
}

class LoggingInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('[ApiResponse] ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('[ApiError] $err\n\tstatus: ${err.response?.statusCode}\n\tbody: ${err.response?.data}');
    super.onError(err, handler);
  }
}

@riverpod
UsersApi usersApi(Ref ref) => ref.watch(apiProvider).getUsersApi();

@riverpod
DiariesApi diariesApi(Ref ref) => ref.watch(apiProvider).getDiariesApi();
