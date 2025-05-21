part of 'page.dart';

@riverpod
HomeAction _homeAction(Ref ref) => HomeAction(ref);

class HomeAction extends FluxAction {
  HomeAction(super.ref) {
    initializeBackgroundService();
  }

  Future<void> writeDiary({required ErrorHandler errorHandler}) async {
    try {
      final photos = ref.read(selectedPhotosProvider);
      final photoStreams = await Future.wait(
        photos.map(
          (photo) async => MultipartFile.fromStream(
            () => photo.openRead(),
            await photo.length(),
            filename: photo.uri.pathSegments.last,
            contentType: DioMediaType.parse(lookupMimeType(photo.path) ?? 'image/jpeg'),
          ),
        ),
      );
      final languageCode = await ref.watch(diaryLanguageProvider.future);

      /* エラーのテスト用
      await Future.delayed(const Duration(milliseconds: 100));
      final builder = ServiceErrorBuilder();
      builder.status = 400;
      builder.code = 'test';
      builder.message = 'Test error message';
      builder.brand = ServiceErrorBrandEnum.serviceError;
      throw DioException(requestOptions: RequestOptions(), response: Response(requestOptions: RequestOptions(), data: builder.build()));
       */

      final res = await postDiaries(ref.read(diariesApiProvider))(
        // locationHistories: ref.read(storedLocationHistoriesProvider),
        locationHistories: [
          LocationHistory(lat: 34.7981499, lng: 135.4592248, visitedAt: DateTime.now().copyWith(hour: 12, minute: 30)),
          // LocationHistory(lat: 34.7848265, lng: 135.4705357, visitedAt: DateTime.now().copyWith(hour: 15, minute: 30)),
        ],
        images: BuiltList.of(photoStreams),
        // diaryLanguage が未設定なのはありえない
        languageCode: languageCode?.code ?? LanguageCode.en,
        memo: ref.read(diaryMemoProvider),
      );

      logger.i('Diary written successfully: ${res.data?.id}');

      ref.read(todaysDiaryProvider.notifier).set(res.data);

    } on DioException catch (e) {
      if (e.response?.data case ServiceError err) {
        errorHandler('${err.code}: ${err.message}');
      } else {
        errorHandler(e.message ?? 'Unknown error occurred');
      }

      logger.e(e);
      return;
    }
  }

  Future<void> addPhoto() async {
    final files = await ImagePicker().pickMultiImage(limit: 4, maxHeight: 5000, maxWidth: 5000);

    if (files.isEmpty) return;

    ref.read(selectedPhotosProvider.notifier).set(files);
  }

  void updateMemo(String value) {
    ref.read(diaryMemoProvider.notifier).set(value);
  }

  void retryFetchDiary() {
    ref.invalidate(todaysDiaryProvider);
  }

  Future<void> deleteDiary(Diary diary, {required ErrorHandler errorHandler}) async {
    try {
      final res = await ref.watch(diariesApiProvider).deleteDiary(diaryId: diary.id);

      if (res.data == null) {
        errorHandler('Failed to regenerate diary');
        return;
      }

      logger.i('Diary deleted successfully: ${res.data?.id}');

      ref.read(todaysDiaryProvider.notifier).set(null);

    } on DioException catch (e) {
      if (e.response?.data case ServiceError err) {
        errorHandler('${err.code}: ${err.message}');
      } else {
        errorHandler(e.message ?? 'Unknown error occurred');
      }

      logger.e(e);
      return;
    }
  }

  Future<void> reportContent(Diary diary) async {

  }
}
