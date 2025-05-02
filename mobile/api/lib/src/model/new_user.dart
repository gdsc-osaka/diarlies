//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'new_user.g.dart';

/// NewUser
///
/// Properties:
/// * [username] - ユーザー名
/// * [email] - メールアドレス
/// * [password] - パスワード
@BuiltValue()
abstract class NewUser implements Built<NewUser, NewUserBuilder> {
  /// ユーザー名
  @BuiltValueField(wireName: r'username')
  String get username;

  /// メールアドレス
  @BuiltValueField(wireName: r'email')
  String get email;

  /// パスワード
  @BuiltValueField(wireName: r'password')
  String get password;

  NewUser._();

  factory NewUser([void updates(NewUserBuilder b)]) = _$NewUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NewUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NewUser> get serializer => _$NewUserSerializer();
}

class _$NewUserSerializer implements PrimitiveSerializer<NewUser> {
  @override
  final Iterable<Type> types = const [NewUser, _$NewUser];

  @override
  final String wireName = r'NewUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NewUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'username';
    yield serializers.serialize(
      object.username,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NewUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NewUserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NewUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NewUserBuilder();
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

