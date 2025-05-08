import 'package:dio/dio.dart';

class ApiError<TError extends Object, TCode extends Enum> {
  ApiError({
    required this.status,
    required this.code,
    required this.message,
    required this.details,
    required this.cause,
    required this.stack,
  });

  final ApiStatus status;
  final TCode? code;
  final String? message;
  final List<Object> details;
  final Object? cause;
  final StackTrace? stack;
}

enum ApiStatus {
  // 0xx Dio and other errors
  unknown(0),
  // dio
  connectionTimeout(1),
  sendTimeout(2),
  receiveTimeout(3),
  badCertificate(4),
  badResponse(5),
  cancel(6),
  connectTimeout(7),
  serializeError(8),
  // auth
  malformedToken(10),
  invalidToken(11),
  authServerError(12),

  // 1xx Informational
  continue_(100),
  switchingProtocols(101),
  processing(102),
  earlyHints(103),

  // 2xx Success
  ok(200),
  created(201),
  accepted(202),
  nonAuthoritativeInformation(203),
  noContent(204),
  resetContent(205),
  partialContent(206),
  multiStatus(207),
  alreadyReported(208),
  imUsed(226),

  // 3xx Redirection
  multipleChoices(300),
  movedPermanently(301),
  found(302),
  seeOther(303),
  notModified(304),
  useProxy(305),
  temporaryRedirect(307),
  permanentRedirect(308),

  // 4xx Client Error
  badRequest(400),
  unauthorized(401),
  paymentRequired(402),
  forbidden(403),
  notFound(404),
  methodNotAllowed(405),
  notAcceptable(406),
  proxyAuthenticationRequired(407),
  requestTimeout(408),
  conflict(409),
  gone(410),
  lengthRequired(411),
  preconditionFailed(412),
  payloadTooLarge(413),
  uriTooLong(414),
  unsupportedMediaType(415),
  rangeNotSatisfiable(416),
  expectationFailed(417),
  imATeapot(418),
  misdirectedRequest(421),
  unprocessableEntity(422),
  locked(423),
  failedDependency(424),
  tooEarly(425),
  upgradeRequired(426),
  preconditionRequired(428),
  tooManyRequests(429),
  requestHeaderFieldsTooLarge(431),
  unavailableForLegalReasons(451),

  // 5xx Server Error
  internalServerError(500),
  notImplemented(501),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504),
  httpVersionNotSupported(505),
  variantAlsoNegotiates(506),
  insufficientStorage(507),
  loopDetected(508),
  notExtended(510),
  networkAuthenticationRequired(511);

  const ApiStatus(this.num);

  final int num;

  static ApiStatus fromStatusCode(int? statusCode) {
    if (statusCode == null) return unknown;

    if (statusCode < 100 || statusCode > 599) {
      return unknown;
    }
    return values.where((status) => status.num == statusCode).firstOrNull ?? unknown;
  }

  static ApiStatus fromDioException(DioExceptionType type) {
    return switch (type) {
      DioExceptionType.connectionTimeout => connectionTimeout,
      DioExceptionType.sendTimeout => sendTimeout,
      DioExceptionType.receiveTimeout => receiveTimeout,
      DioExceptionType.badCertificate => badCertificate,
      DioExceptionType.badResponse => badResponse,
      DioExceptionType.cancel => cancel,
      DioExceptionType.connectionError => connectTimeout,
      DioExceptionType.unknown => unknown,
    };
  }
}
