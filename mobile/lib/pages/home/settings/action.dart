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

  Future<void> changeAccountVisibility(AccountVisibility? visibility, {
    required SuccessHandler<String> successHandler,
    required ErrorHandler errorHandler}) async {
    final usersApi = ref.read(usersApiProvider);
    final userId = ref.read(currentUserProvider).valueOrNull?.id;

    if (userId == null) {
      throw Exception('User ID is null');
    }

    final requestBuilder = ChangeUserVisibilityRequestBuilder();
    requestBuilder.visibility = visibility;

    try {
      final res = await usersApi.postUsersByUserIdChangeVisibility(userId: userId, changeUserVisibilityRequest: requestBuilder.build());
      final user = res.data;

      if (user == null) {
        throw Exception('Failed to change account visibility (Response#data is null)');
      }

      ref.read(currentUserProvider.notifier).setUser(user);

      successHandler(t.settings.success.change_visibility);

    } on DioException catch (e) {
      final serviceError = safeSerializeServiceError(e);

      if (serviceError.isOk) {
        errorHandler('${serviceError.ok()!.code}: ${serviceError.ok()!.message}');
      } else {
        errorHandler('${e.message}');
      }

      logger.e('Error changing account visibility: $e');
    }
  }
}