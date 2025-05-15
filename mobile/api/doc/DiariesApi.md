# api.api.DiariesApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteDiariesByDiaryId**](DiariesApi.md#deletediariesbydiaryid) | **DELETE** /diaries/{diaryId} | 
[**getDiaries**](DiariesApi.md#getdiaries) | **GET** /diaries | 
[**postDiaries**](DiariesApi.md#postdiaries) | **POST** /diaries | 


# **deleteDiariesByDiaryId**
> Diary deleteDiariesByDiaryId(diaryId)



Delete a diary

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDiariesApi();
final String diaryId = diaryId_example; // String | Diary ID to delete

try {
    final response = api.deleteDiariesByDiaryId(diaryId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DiariesApi->deleteDiariesByDiaryId: $e\n');
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
> BuiltList<Diary> getDiaries(date)



Get diaries

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDiariesApi();
final Date date = 2013-10-20; // Date | Date to filter diaries

try {
    final response = api.getDiaries(date);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DiariesApi->getDiaries: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **Date**| Date to filter diaries | [optional] 

### Return type

[**BuiltList&lt;Diary&gt;**](Diary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postDiaries**
> Diary postDiaries(locationHistories, languageCode, images)



Create a new diary

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDiariesApi();
final String locationHistories = locationHistories_example; // String | Location histories for diary generation
final LanguageCode languageCode = ; // LanguageCode | 
final BuiltList<MultipartFile> images = /path/to/file.txt; // BuiltList<MultipartFile> | 

try {
    final response = api.postDiaries(locationHistories, languageCode, images);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DiariesApi->postDiaries: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **locationHistories** | **String**| Location histories for diary generation | 
 **languageCode** | [**LanguageCode**](LanguageCode.md)|  | 
 **images** | [**BuiltList&lt;MultipartFile&gt;**](MultipartFile.md)|  | 

### Return type

[**Diary**](Diary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

