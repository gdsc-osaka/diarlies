part of 'page.dart';

@riverpod
HomeAction _homeAction(Ref ref) => HomeAction(ref);

class HomeAction extends FluxAction {
  HomeAction(super.ref);

  Future<void> writeDiary() async {

  }

  Future<void> addPhoto() async {
    final files = await ImagePicker().pickMultiImage(
      limit: 4,
      maxHeight: 5000,
      maxWidth: 5000,
    );

    if (files.isEmpty) return;

    ref.read(selectedPhotosProvider.notifier).set(files);
  }

  void updateMemo(String value) {
    ref.read(diaryMemoProvider.notifier).set(value);
  }
}