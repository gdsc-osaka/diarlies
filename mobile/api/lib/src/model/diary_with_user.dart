//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api/src/model/diary.dart';
import 'package:api/src/model/day.dart';
import 'package:api/src/model/timestamp.dart';
import 'package:api/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'diary_with_user.g.dart';

/// DiaryWithUser
///
/// Properties:
/// * [user] 
/// * [id] 
/// * [content] 
/// * [diaryDate] 
/// * [thumbnailUrl] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class DiaryWithUser implements Diary, Built<DiaryWithUser, DiaryWithUserBuilder> {
  @BuiltValueField(wireName: r'user')
  User get user;

  DiaryWithUser._();

  factory DiaryWithUser([void updates(DiaryWithUserBuilder b)]) = _$DiaryWithUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DiaryWithUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DiaryWithUser> get serializer => _$DiaryWithUserSerializer();
}

class _$DiaryWithUserSerializer implements PrimitiveSerializer<DiaryWithUser> {
  @override
  final Iterable<Type> types = const [DiaryWithUser, _$DiaryWithUser];

  @override
  final String wireName = r'DiaryWithUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DiaryWithUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(Timestamp),
    );
    yield r'diaryDate';
    yield serializers.serialize(
      object.diaryDate,
      specifiedType: const FullType(Day),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(User),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    yield r'thumbnailUrl';
    yield serializers.serialize(
      object.thumbnailUrl,
      specifiedType: const FullType(String),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(Timestamp),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DiaryWithUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DiaryWithUserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Timestamp),
          ) as Timestamp;
          result.createdAt.replace(valueDes);
          break;
        case r'diaryDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Day),
          ) as Day;
          result.diaryDate.replace(valueDes);
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(User),
          ) as User;
          result.user.replace(valueDes);
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'thumbnailUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.thumbnailUrl = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Timestamp),
          ) as Timestamp;
          result.updatedAt.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DiaryWithUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DiaryWithUserBuilder();
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

