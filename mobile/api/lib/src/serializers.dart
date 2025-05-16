//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:api/src/date_serializer.dart';
import 'package:api/src/model/date.dart';

import 'package:api/src/model/account_visibility.dart';
import 'package:api/src/model/change_user_visibility_request.dart';
import 'package:api/src/model/create_user_service_error.dart';
import 'package:api/src/model/day.dart';
import 'package:api/src/model/diary.dart';
import 'package:api/src/model/diary_with_user.dart';
import 'package:api/src/model/language_code.dart';
import 'package:api/src/model/service_error.dart';
import 'package:api/src/model/timestamp.dart';
import 'package:api/src/model/user.dart';

part 'serializers.g.dart';

@SerializersFor([
  AccountVisibility,
  ChangeUserVisibilityRequest,
  CreateUserServiceError,
  Day,
  Diary,$Diary,
  DiaryWithUser,
  LanguageCode,
  ServiceError,
  Timestamp,
  User,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Diary)]),
        () => ListBuilder<Diary>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(DiaryWithUser)]),
        () => ListBuilder<DiaryWithUser>(),
      )
      ..add(Diary.serializer)
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
