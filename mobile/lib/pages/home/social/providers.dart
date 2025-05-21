part of 'page.dart';

@Riverpod(keepAlive: true)
class DiariesInTimeline extends _$DiariesInTimeline {
  @override
  Future<List<DiaryWithUser>> build() async {
    final diariesApi = ref.watch(diariesApiProvider);

    // AccountVisibility が変化するとタイムラインに表示される日記が変わるので、再度フェッチする
    ref.listen(currentAccountVisibilityProvider, (prev, next) {
      if (prev?.hasValue == true && next.hasValue && prev?.value != next.value) {
        ref.invalidateSelf();
      }
    });

    try {
      final diaries = await diariesApi.getDiaries(
        startDate: DateTime.now().subtract(const Duration(days: 7)).toDate(),
        endDate: DateTime.now().toDate(),
      );

      return diaries.data?.toList() ?? [];
    } on DioException catch (e) {
      logger.e('Failed to fetch diaries $e');
      if (e.response?.statusCode == 404) {
        return [];
      }

      final serviceError = safeDeserializeServiceError(e);

      if (serviceError.isOk) {
        return Future.error("${serviceError.ok()!.status}: ${serviceError.ok()!.message}");
      }

      return Future.error('${e.response?.statusCode}: ${e.response?.statusMessage}');
    }
  }
}
