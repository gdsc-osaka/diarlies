import 'package:test/test.dart';
import 'package:api/api.dart';


/// tests for DiariesApi
void main() {
  final instance = Api().getDiariesApi();

  group(DiariesApi, () {
    // Create a new diary
    //
    //Future<Diary> postDiaries(String locationHistories, BuiltList<MultipartFile> images, { LanguageCode languageCode }) async
    test('test postDiaries', () async {
      // TODO
    });

  });
}
