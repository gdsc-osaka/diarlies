import 'package:test/test.dart';
import 'package:api/api.dart';


/// tests for DiariesApi
void main() {
  final instance = Api().getDiariesApi();

  group(DiariesApi, () {
    // Create a new diary
    //
    //Future<Diary> createDiary(String locationHistories, LanguageCode languageCode, BuiltList<MultipartFile> images) async
    test('test createDiary', () async {
      // TODO
    });

    // Delete a diary
    //
    //Future<Diary> deleteDiary(String diaryId) async
    test('test deleteDiary', () async {
      // TODO
    });

    // Get diaries
    //
    //Future<BuiltList<DiaryWithUser>> getDiaries({ Date startDate, Date endDate }) async
    test('test getDiaries', () async {
      // TODO
    });

    // Get diaries
    //
    //Future<BuiltList<Diary>> getDiariesByUser(String userId, { Date date }) async
    test('test getDiariesByUser', () async {
      // TODO
    });

  });
}
