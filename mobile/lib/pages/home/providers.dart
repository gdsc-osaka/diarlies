part of 'page.dart';

@riverpod
class SelectedPhotos extends _$SelectedPhotos {
  @override
  List<File> build() {
    return [];
  }

  void set(List<XFile> files) {
    state = files.map((e) => File(e.path)).toList();
  }
}

@riverpod
class DiaryMemo extends _$DiaryMemo {
  @override
  String? build() {
    return null;
  }

  void set(String value) {
    state = value;
  }
}

@riverpod
class TodaysDiary extends _$TodaysDiary {
  @override
  Future<Diary?> build() async {
    final diariesApi = ref.watch(diariesApiProvider);

    try {
      final diary = await diariesApi.getDiariesByUser(
        userId: ref.watch(currentUserProvider).valueOrNull?.id ?? '',
        date: DateTime.now().toDate(),
      );

      return diary.data?.firstOrNull;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }

      if (e.response?.data case ServiceError err) {
        return Future.error(err);
      } else {
        return Future.error(e.message ?? 'Unknown error occurred');
      }
    }
  }

  void set(Diary? value) {
    state = AsyncValue.data(value);
  }
}