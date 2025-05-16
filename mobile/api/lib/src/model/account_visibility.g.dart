// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_visibility.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountVisibility _$private = const AccountVisibility._('private');
const AccountVisibility _$public = const AccountVisibility._('public');

AccountVisibility _$valueOf(String name) {
  switch (name) {
    case 'private':
      return _$private;
    case 'public':
      return _$public;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AccountVisibility> _$values =
    new BuiltSet<AccountVisibility>(const <AccountVisibility>[
  _$private,
  _$public,
]);

class _$AccountVisibilityMeta {
  const _$AccountVisibilityMeta();
  AccountVisibility get private => _$private;
  AccountVisibility get public => _$public;
  AccountVisibility valueOf(String name) => _$valueOf(name);
  BuiltSet<AccountVisibility> get values => _$values;
}

abstract class _$AccountVisibilityMixin {
  // ignore: non_constant_identifier_names
  _$AccountVisibilityMeta get AccountVisibility =>
      const _$AccountVisibilityMeta();
}

Serializer<AccountVisibility> _$accountVisibilitySerializer =
    new _$AccountVisibilitySerializer();

class _$AccountVisibilitySerializer
    implements PrimitiveSerializer<AccountVisibility> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'private': 'private',
    'public': 'public',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'private': 'private',
    'public': 'public',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountVisibility];
  @override
  final String wireName = 'AccountVisibility';

  @override
  Object serialize(Serializers serializers, AccountVisibility object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccountVisibility deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccountVisibility.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
