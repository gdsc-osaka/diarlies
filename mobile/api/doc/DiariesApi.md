# api.api.DiariesApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://diarlies.web.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createDiary**](DiariesApi.md#creatediary) | **POST** /api/diaries | 
[**deleteDiary**](DiariesApi.md#deletediary) | **DELETE** /api/diaries/{diaryId} | 
[**getDiaries**](DiariesApi.md#getdiaries) | **GET** /api/diaries | 
[**getDiariesByUser**](DiariesApi.md#getdiariesbyuser) | **GET** /api/users/{userId}/diaries | 


# **createDiary**
> Diary createDiary(locationHistories, languageCode, images, memo)



Create a new diary

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDiariesApi();
final String locationHistories = locationHistories_example; // String | Location histories for diary generation
final LanguageCode languageCode = ; // LanguageCode | 
final BuiltList<MultipartFile> images = /path/to/file.txt; // BuiltList<MultipartFile> | 
final String memo = memo_example; // String | Memo for diary generation

try {
    final response = api.createDiary(locationHistories, languageCode, images, memo);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DiariesApi->createDiary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **locationHistories** | **String**| Location histories for diary generation | 
 **languageCode** | [**LanguageCode**](LanguageCode.md)|  | 
 **images** | [**BuiltList&lt;MultipartFile&gt;**](MultipartFile.md)|  | 
 **memo** | **String**| Memo for diary generation | [optional] 

### Return type

[**Diary**](Diary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDiary**
> Diary deleteDiary(diaryId)



Delete a diary

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDiariesApi();
final String diaryId = diaryId_example; // String | Diary ID to delete

try {
    final response = api.deleteDiary(diaryId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DiariesApi->deleteDiary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **diaryId** | **String**| Diary ID to delete | 

### Return type

[**Diary**](Diary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDiaries**
> BuiltList<DiaryWithUser> getDiaries(startDate, endDate)



Get diaries

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDiariesApi();
final Date startDate = 2013-10-20; // Date | Start date to filter diaries
final Date endDate = 2013-10-20; // Date | End date to filter diaries

try {
    final response = api.getDiaries(startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DiariesApi->getDiaries: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **Date**| Start date to filter diaries | [optional] 
 **endDate** | **Date**| End date to filter diaries | [optional] 

### Return type

[**BuiltList&lt;DiaryWithUser&gt;**](DiaryWithUser.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDiariesByUser**
> BuiltList<Diary> getDiariesByUser(userId, date)



Get diaries

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDiariesApi();
final String userId = userId_example; // String | 
final Date date = 2013-10-20; // Date | Date to filter diaries. startDate and endDate will be ignored if this is provided

try {
    final response = api.getDiariesByUser(userId, date);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DiariesApi->getDiariesByUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **date** | **Date**| Date to filter diaries. startDate and endDate will be ignored if this is provided | [optional] 

### Return type

[**BuiltList&lt;Diary&gt;**](Diary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

