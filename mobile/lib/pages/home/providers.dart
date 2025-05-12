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