//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'timestamp.g.dart';

/// Timestamp
///
/// Properties:
/// * [seconds] 
/// * [nanoseconds] 
@BuiltValue()
abstract class Timestamp implements Built<Timestamp, TimestampBuilder> {
  @BuiltValueField(wireName: r'seconds')
  int get seconds;

  @BuiltValueField(wireName: r'nanoseconds')
  int get nanoseconds;

  Timestamp._();

  factory Timestamp([void updates(TimestampBuilder b)]) = _$Timestamp;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TimestampBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Timestamp> get serializer => _$TimestampSerializer();
}

class _$TimestampSerializer implements PrimitiveSerializer<Timestamp> {
  @override
  final Iterable<Type> types = const [Timestamp, _$Timestamp];

  @override
  final String wireName = r'Timestamp';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Timestamp object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'seconds';
    yield serializers.serialize(
      object.seconds,
      specifiedType: const FullType(int),
    );
    yield r'nanoseconds';
    yield serializers.serialize(
      object.nanoseconds,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Timestamp object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TimestampBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'seconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.seconds = valueDes;
          break;
        case r'nanoseconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.nanoseconds = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Timestamp deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TimestampBuilder();
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

