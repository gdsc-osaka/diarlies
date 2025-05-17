import 'package:api/api.dart';
import 'package:built_value/serializer.dart';
import 'package:diarlies/shared/result.dart';
import 'package:dio/dio.dart';

Result<ServiceError, Exception> safeDeserializeServiceError(DioException e) {
  try {
    final serviceError = standardSerializers.deserialize(
      e.response?.data,
      specifiedType: const FullType(ServiceError),
    ) as ServiceError;
    return Ok(serviceError);

  } on Exception catch (e) {
    return Err(e);
  }
}
