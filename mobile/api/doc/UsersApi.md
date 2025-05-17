# api.api.UsersApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://diarlies.web.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**changeUserVisibility**](UsersApi.md#changeuservisibility) | **POST** /api/users/{userId}/change-visibility | 
[**createUser**](UsersApi.md#createuser) | **POST** /api/users | 
[**getUser**](UsersApi.md#getuser) | **GET** /api/users | 


# **changeUserVisibility**
> User changeUserVisibility(userId, changeUserVisibilityRequest)



Change user visibility

### Example
```dart
import 'package:api/api.dart';

final api = Api().getUsersApi();
final String userId = userId_example; // String | User ID to change visibility
final ChangeUserVisibilityRequest changeUserVisibilityRequest = ; // ChangeUserVisibilityRequest | 

try {
    final response = api.changeUserVisibility(userId, changeUserVisibilityRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->changeUserVisibility: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| User ID to change visibility | 
 **changeUserVisibilityRequest** | [**ChangeUserVisibilityRequest**](ChangeUserVisibilityRequest.md)|  | 

### Return type

[**User**](User.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createUser**
> User createUser()



Create a new user

### Example
```dart
import 'package:api/api.dart';

final api = Api().getUsersApi();

try {
    final response = api.createUser();
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->createUser: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUser**
> User getUser()



Get user information

### Example
```dart
import 'package:api/api.dart';

final api = Api().getUsersApi();

try {
    final response = api.getUser();
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->getUser: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

