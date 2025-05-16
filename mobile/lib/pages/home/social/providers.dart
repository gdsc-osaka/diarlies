part of 'page.dart';

@Riverpod(keepAlive: true)
class DiariesInTimeline extends _$DiariesInTimeline {
  @override
  Future<List<Diary>> build() async {
    final diariesApi = ref.watch(diariesApiProvider);

    try {
      final diaries = await diariesApi.getDiaries(
        startDate: DateTime.now().subtract(const Duration(days: 7)).toDate(),
        endDate: DateTime.now().toDate(),
      );

      return diaries.data?.toList() ?? [];
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }

      if (e.response?.data case ServiceError err) {
        return Future.error(err.message);
      } else {
        return Future.error(e.message ?? 'Unknown error occurred');
      }
    }
  }
}
