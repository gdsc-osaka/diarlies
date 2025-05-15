//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'language_code.g.dart';

class LanguageCode extends EnumClass {

  /// Language code for diary generation
  @BuiltValueEnumConst(wireName: r'ja')
  static const LanguageCode ja = _$ja;
  /// Language code for diary generation
  @BuiltValueEnumConst(wireName: r'en')
  static const LanguageCode en = _$en;
  /// Language code for diary generation
  @BuiltValueEnumConst(wireName: r'ko')
  static const LanguageCode ko = _$ko;
  /// Language code for diary generation
  @BuiltValueEnumConst(wireName: r'zh')
  static const LanguageCode zh = _$zh;
  /// Language code for diary generation
  @BuiltValueEnumConst(wireName: r'fr')
  static const LanguageCode fr = _$fr;
  /// Language code for diary generation
  @BuiltValueEnumConst(wireName: r'es')
  static const LanguageCode es = _$es;

  static Serializer<LanguageCode> get serializer => _$languageCodeSerializer;

  const LanguageCode._(String name): super(name);

  static BuiltSet<LanguageCode> get values => _$values;
  static LanguageCode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LanguageCodeMixin = Object with _$LanguageCodeMixin;

