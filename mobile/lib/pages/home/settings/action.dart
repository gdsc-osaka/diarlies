part of 'page.dart';

@riverpod
HomeSettingsAction _homeSettingsAction(Ref ref) {
  return HomeSettingsAction(ref);
}

class HomeSettingsAction extends FluxAction {
  HomeSettingsAction(super.ref);

  Future<void> signOut() async {
    final auth = ref.read(authProvider);
    await auth.signOut();
    
    ref.invalidate(currentUserProvider);
  }
}