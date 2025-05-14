# api.api.DiariesApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**postDiaries**](DiariesApi.md#postdiaries) | **POST** /diaries | 


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

