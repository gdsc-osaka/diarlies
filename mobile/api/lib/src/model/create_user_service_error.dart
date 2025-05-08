//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_user_service_error.g.dart';

/// CreateUserServiceError
///
/// Properties:
/// * [status] 
/// * [message] 
/// * [code] 
/// * [brand] 
/// * [user] 
@BuiltValue()
abstract class CreateUserServiceError implements Built<CreateUserServiceError, CreateUserServiceErrorBuilder> {
  @BuiltValueField(wireName: r'status')
  int get status;

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'code')
  CreateUserServiceErrorCodeEnum? get code;
  // enum codeEnum {  user-already-exists,  unknown,  };

  @BuiltValueField(wireName: r'__brand')
  CreateUserServiceErrorBrandEnum get brand;
  // enum brandEnum {  ServiceError,  };

  @BuiltValueField(wireName: r'user')
  User? get user;

  CreateUserServiceError._();

  factory CreateUserServiceError([void updates(CreateUserServiceErrorBuilder b)]) = _$CreateUserServiceError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateUserServiceErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateUserServiceError> get serializer => _$CreateUserServiceErrorSerializer();
}

class _$CreateUserServiceErrorSerializer implements PrimitiveSerializer<CreateUserServiceError> {
  @override
  final Iterable<Type> types = const [CreateUserServiceError, _$CreateUserServiceError];

  @override
  final String wireName = r'CreateUserServiceError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateUserServiceError object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(int),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(CreateUserServiceErrorCodeEnum),
      );
    }
    yield r'__brand';
    yield serializers.serialize(
      object.brand,
      specifiedType: const FullType(CreateUserServiceErrorBrandEnum),
    );
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(User),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateUserServiceError object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateUserServiceErrorBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateUserServiceErrorCodeEnum),
          ) as CreateUserServiceErrorCodeEnum;
          result.code = valueDes;
          break;
        case r'__brand':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateUserServiceErrorBrandEnum),
          ) as CreateUserServiceErrorBrandEnum;
          result.brand = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(User),
          ) as User;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateUserServiceError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateUserServiceErrorBuilder();
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

class CreateUserServiceErrorCodeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user-already-exists')
  static const CreateUserServiceErrorCodeEnum userAlreadyExists = _$createUserServiceErrorCodeEnum_userAlreadyExists;
  @BuiltValueEnumConst(wireName: r'unknown')
  static const CreateUserServiceErrorCodeEnum unknown = _$createUserServiceErrorCodeEnum_unknown;

  static Serializer<CreateUserServiceErrorCodeEnum> get serializer => _$createUserServiceErrorCodeEnumSerializer;

  const CreateUserServiceErrorCodeEnum._(String name): super(name);

  static BuiltSet<CreateUserServiceErrorCodeEnum> get values => _$createUserServiceErrorCodeEnumValues;
  static CreateUserServiceErrorCodeEnum valueOf(String name) => _$createUserServiceErrorCodeEnumValueOf(name);
}

class CreateUserServiceErrorBrandEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ServiceError')
  static const CreateUserServiceErrorBrandEnum serviceError = _$createUserServiceErrorBrandEnum_serviceError;

  static Serializer<CreateUserServiceErrorBrandEnum> get serializer => _$createUserServiceErrorBrandEnumSerializer;

  const CreateUserServiceErrorBrandEnum._(String name): super(name);

  static BuiltSet<CreateUserServiceErrorBrandEnum> get values => _$createUserServiceErrorBrandEnumValues;
  static CreateUserServiceErrorBrandEnum valueOf(String name) => _$createUserServiceErrorBrandEnumValueOf(name);
}

