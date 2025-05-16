import 'package:test/test.dart';
import 'package:api/api.dart';


/// tests for DiariesApi
void main() {
  final instance = Api().getDiariesApi();

  group(DiariesApi, () {
    // Delete a diary
    //
    //Future<Diary> deleteDiariesByDiaryId(String diaryId) async
    test('test deleteDiariesByDiaryId', () async {
      // TODO
    });

    // Get diaries
    //
    //Future<BuiltList<Diary>> getDiaries({ Date startDate, Date endDate }) async
    test('test getDiaries', () async {
      // TODO
    });

    // Get diaries
    //
    //Future<BuiltList<Diary>> getUsersByUserIdDiaries(String userId, { Date date }) async
    test('test getUsersByUserIdDiaries', () async {
      // TODO
    });

    // Create a new diary
    //
    //Future<Diary> postDiaries(String locationHistories, LanguageCode languageCode, BuiltList<MultipartFile> images) async
    test('test postDiaries', () async {
      // TODO
    });

  });
}
