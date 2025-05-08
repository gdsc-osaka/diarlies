part of 'page.dart';

@Riverpod(keepAlive: true)
class DiaryLanguage extends _$DiaryLanguage {
  @override
  Language? build() {
    return null;
  }

  void setLanguage(Language language) {
    state = language;
  }
}