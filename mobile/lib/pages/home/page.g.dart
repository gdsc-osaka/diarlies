// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeActionHash() => r'b3a76022524649a4a2a6867df86804f641f96e47';

/// See also [_homeAction].
@ProviderFor(_homeAction)
final _homeActionProvider = AutoDisposeProvider<HomeAction>.internal(
  _homeAction,
  name: r'_homeActionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$homeActionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _HomeActionRef = AutoDisposeProviderRef<HomeAction>;
String _$selectedPhotosHash() => r'66302fddbe15479c28faf218b4004cd12a3af14f';

/// See also [SelectedPhotos].
@ProviderFor(SelectedPhotos)
final selectedPhotosProvider =
    AutoDisposeNotifierProvider<SelectedPhotos, List<File>>.internal(
      SelectedPhotos.new,
      name: r'selectedPhotosProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedPhotosHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedPhotos = AutoDisposeNotifier<List<File>>;
String _$diaryMemoHash() => r'96ba65d31c2ce42d938e010c17775ee27dd3fffc';

/// See also [DiaryMemo].
@ProviderFor(DiaryMemo)
final diaryMemoProvider =
    AutoDisposeNotifierProvider<DiaryMemo, String?>.internal(
      DiaryMemo.new,
      name: r'diaryMemoProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$diaryMemoHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DiaryMemo = AutoDisposeNotifier<String?>;
String _$todaysDiaryHash() => r'4523fa43ee255bf25ca4adc7a0b43159f0d203ae';

/// See also [TodaysDiary].
@ProviderFor(TodaysDiary)
final todaysDiaryProvider =
    AutoDisposeAsyncNotifierProvider<TodaysDiary, Diary?>.internal(
      TodaysDiary.new,
      name: r'todaysDiaryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$todaysDiaryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodaysDiary = AutoDisposeAsyncNotifier<Diary?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
