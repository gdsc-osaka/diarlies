//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'report_inappropriate_diary_request.g.dart';

/// ReportInappropriateDiaryRequest
///
/// Properties:
/// * [reason] - Reason for reporting the diary
@BuiltValue()
abstract class ReportInappropriateDiaryRequest implements Built<ReportInappropriateDiaryRequest, ReportInappropriateDiaryRequestBuilder> {
  /// Reason for reporting the diary
  @BuiltValueField(wireName: r'reason')
  String get reason;

  ReportInappropriateDiaryRequest._();

  factory ReportInappropriateDiaryRequest([void updates(ReportInappropriateDiaryRequestBuilder b)]) = _$ReportInappropriateDiaryRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReportInappropriateDiaryRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReportInappropriateDiaryRequest> get serializer => _$ReportInappropriateDiaryRequestSerializer();
}

class _$ReportInappropriateDiaryRequestSerializer implements PrimitiveSerializer<ReportInappropriateDiaryRequest> {
  @override
  final Iterable<Type> types = const [ReportInappropriateDiaryRequest, _$ReportInappropriateDiaryRequest];

  @override
  final String wireName = r'ReportInappropriateDiaryRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReportInappropriateDiaryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReportInappropriateDiaryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReportInappropriateDiaryRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReportInappropriateDiaryRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReportInappropriateDiaryRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

