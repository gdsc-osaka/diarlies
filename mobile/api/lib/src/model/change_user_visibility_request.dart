//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api/src/model/account_visibility.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_user_visibility_request.g.dart';

/// ChangeUserVisibilityRequest
///
/// Properties:
/// * [visibility] 
@BuiltValue()
abstract class ChangeUserVisibilityRequest implements Built<ChangeUserVisibilityRequest, ChangeUserVisibilityRequestBuilder> {
  @BuiltValueField(wireName: r'visibility')
  AccountVisibility get visibility;
  // enum visibilityEnum {  private,  public,  };

  ChangeUserVisibilityRequest._();

  factory ChangeUserVisibilityRequest([void updates(ChangeUserVisibilityRequestBuilder b)]) = _$ChangeUserVisibilityRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangeUserVisibilityRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangeUserVisibilityRequest> get serializer => _$ChangeUserVisibilityRequestSerializer();
}

class _$ChangeUserVisibilityRequestSerializer implements PrimitiveSerializer<ChangeUserVisibilityRequest> {
  @override
  final Iterable<Type> types = const [ChangeUserVisibilityRequest, _$ChangeUserVisibilityRequest];

  @override
  final String wireName = r'ChangeUserVisibilityRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangeUserVisibilityRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'visibility';
    yield serializers.serialize(
      object.visibility,
      specifiedType: const FullType(AccountVisibility),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangeUserVisibilityRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangeUserVisibilityRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'visibility':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountVisibility),
          ) as AccountVisibility;
          result.visibility = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChangeUserVisibilityRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangeUserVisibilityRequestBuilder();
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

