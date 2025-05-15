// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_code.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LanguageCode _$ja = const LanguageCode._('ja');
const LanguageCode _$en = const LanguageCode._('en');
const LanguageCode _$ko = const LanguageCode._('ko');
const LanguageCode _$zh = const LanguageCode._('zh');
const LanguageCode _$fr = const LanguageCode._('fr');
const LanguageCode _$es = const LanguageCode._('es');

LanguageCode _$valueOf(String name) {
  switch (name) {
    case 'ja':
      return _$ja;
    case 'en':
      return _$en;
    case 'ko':
      return _$ko;
    case 'zh':
      return _$zh;
    case 'fr':
      return _$fr;
    case 'es':
      return _$es;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<LanguageCode> _$values =
    new BuiltSet<LanguageCode>(const <LanguageCode>[
  _$ja,
  _$en,
  _$ko,
  _$zh,
  _$fr,
  _$es,
]);

class _$LanguageCodeMeta {
  const _$LanguageCodeMeta();
  LanguageCode get ja => _$ja;
  LanguageCode get en => _$en;
  LanguageCode get ko => _$ko;
  LanguageCode get zh => _$zh;
  LanguageCode get fr => _$fr;
  LanguageCode get es => _$es;
  LanguageCode valueOf(String name) => _$valueOf(name);
  BuiltSet<LanguageCode> get values => _$values;
}

abstract class _$LanguageCodeMixin {
  // ignore: non_constant_identifier_names
  _$LanguageCodeMeta get LanguageCode => const _$LanguageCodeMeta();
}

Serializer<LanguageCode> _$languageCodeSerializer =
    new _$LanguageCodeSerializer();

class _$LanguageCodeSerializer implements PrimitiveSerializer<LanguageCode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ja': 'ja',
    'en': 'en',
    'ko': 'ko',
    'zh': 'zh',
    'fr': 'fr',
    'es': 'es',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ja': 'ja',
    'en': 'en',
    'ko': 'ko',
    'zh': 'zh',
    'fr': 'fr',
    'es': 'es',
  };

  @override
  final Iterable<Type> types = const <Type>[LanguageCode];
  @override
  final String wireName = 'LanguageCode';

  @override
  Object serialize(Serializers serializers, LanguageCode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LanguageCode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LanguageCode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
