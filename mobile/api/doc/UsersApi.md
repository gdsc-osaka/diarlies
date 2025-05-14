# api.api.UsersApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getUsers**](UsersApi.md#getusers) | **GET** /users | 
[**postUsers**](UsersApi.md#postusers) | **POST** /users | 


# **getUsers**
> User getUsers()



Get user information

### Example
```dart
import 'package:api/api.dart';

final api = Api().getUsersApi();

try {
    final response = api.getUsers();
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->getUsers: $e\n');
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

# **postUsers**
> User postUsers()



Create a new user

### Example
```dart
import 'package:api/api.dart';

final api = Api().getUsersApi();

try {
    final response = api.postUsers();
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->postUsers: $e\n');
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

