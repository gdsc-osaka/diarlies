# api.api.UsersApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://api.example.com/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](UsersApi.md#createuser) | **POST** /users | 新しいユーザーを作成
[**getUserById**](UsersApi.md#getuserbyid) | **GET** /users/{userId} | 特定のユーザー情報を取得
[**getUsers**](UsersApi.md#getusers) | **GET** /users | ユーザーリストを取得


# **createUser**
> User createUser(newUser)

新しいユーザーを作成

新しいユーザーをシステムに登録します。

### Example
```dart
import 'package:api/api.dart';

final api = Api().getUsersApi();
final NewUser newUser = ; // NewUser | 作成するユーザー情報

try {
    final response = api.createUser(newUser);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **newUser** | [**NewUser**](NewUser.md)| 作成するユーザー情報 | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserById**
> User getUserById(userId)

特定のユーザー情報を取得

### Example
```dart
import 'package:api/api.dart';

final api = Api().getUsersApi();
final String userId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 取得するユーザーのID

try {
    final response = api.getUserById(userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->getUserById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| 取得するユーザーのID | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUsers**
> BuiltList<User> getUsers(limit, offset)

ユーザーリストを取得

登録されているユーザーのリストを返します。

### Example
```dart
import 'package:api/api.dart';

final api = Api().getUsersApi();
final int limit = 56; // int | 返すユーザー数の上限
final int offset = 56; // int | リストの開始位置オフセット

try {
    final response = api.getUsers(limit, offset);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->getUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**| 返すユーザー数の上限 | [optional] [default to 20]
 **offset** | **int**| リストの開始位置オフセット | [optional] [default to 0]

### Return type

[**BuiltList&lt;User&gt;**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

