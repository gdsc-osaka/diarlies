//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_visibility.g.dart';

class AccountVisibility extends EnumClass {

  @BuiltValueEnumConst(wireName: r'private')
  static const AccountVisibility private = _$private;
  @BuiltValueEnumConst(wireName: r'public')
  static const AccountVisibility public = _$public;

  static Serializer<AccountVisibility> get serializer => _$accountVisibilitySerializer;

  const AccountVisibility._(String name): super(name);

  static BuiltSet<AccountVisibility> get values => _$values;
  static AccountVisibility valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AccountVisibilityMixin = Object with _$AccountVisibilityMixin;

