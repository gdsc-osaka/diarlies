part of 'page.dart';

@riverpod
Future<AccountVisibility?> currentAccountVisibility(Ref ref) async {
  final user = await ref.watch(currentUserProvider.future);

  return user?.visibility;
}