//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api/src/model/day.dart';
import 'package:api/src/model/timestamp.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'diary.g.dart';

/// Diary
///
/// Properties:
/// * [id] 
/// * [content] 
/// * [diaryDate] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class Diary implements Built<Diary, DiaryBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'content')
  String get content;

  @BuiltValueField(wireName: r'diaryDate')
  Day get diaryDate;

  @BuiltValueField(wireName: r'createdAt')
  Timestamp get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  Timestamp get updatedAt;

  Diary._();

  factory Diary([void updates(DiaryBuilder b)]) = _$Diary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DiaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Diary> get serializer => _$DiarySerializer();
}

class _$DiarySerializer implements PrimitiveSerializer<Diary> {
  @override
  final Iterable<Type> types = const [Diary, _$Diary];

  @override
  final String wireName = r'Diary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Diary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    yield r'diaryDate';
    yield serializers.serialize(
      object.diaryDate,
      specifiedType: const FullType(Day),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(Timestamp),
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
    Diary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DiaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'diaryDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Day),
          ) as Day;
          result.diaryDate.replace(valueDes);
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Timestamp),
          ) as Timestamp;
          result.createdAt.replace(valueDes);
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
  Diary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DiaryBuilder();
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

