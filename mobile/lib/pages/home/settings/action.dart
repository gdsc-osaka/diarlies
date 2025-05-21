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

  Future<void> changeAccountVisibility(
    AccountVisibility? visibility, {
    required SuccessHandler<String> successHandler,
    required ErrorHandler errorHandler,
  }) async {
    final usersApi = ref.read(usersApiProvider);
    final userId = ref.read(currentUserProvider).valueOrNull?.id;

    if (userId == null) {
      throw Exception('User ID is null');
    }

    final requestBuilder = ChangeUserVisibilityRequestBuilder();
    requestBuilder.visibility = visibility;

    try {
      final res = await usersApi.changeUserVisibility(
        userId: userId,
        changeUserVisibilityRequest: requestBuilder.build(),
      );
      final user = res.data;

      if (user == null) {
        throw Exception('Failed to change account visibility (Response#data is null)');
      }

      ref.read(currentUserProvider.notifier).setUser(user);

      successHandler(t.home_settings.success.change_visibility);
    } on DioException catch (e) {
      final serviceError = safeDeserializeServiceError(e);

      if (serviceError.isOk) {
        errorHandler('${serviceError.ok()!.code}: ${serviceError.ok()!.message}');
      } else {
        errorHandler('${e.message}');
      }

      logger.e('Error changing account visibility: $e');
    }
  }

  Future<void> deleteAccount({
    required SuccessHandler<String> successHandler,
    required ErrorHandler errorHandler,
  }) async {
    final usersApi = ref.read(usersApiProvider);
    final userId = ref.read(currentUserProvider).valueOrNull?.id;

    if (userId == null) {
      throw Exception('User ID is null');
    }

    try {
      final res = await usersApi.deleteUser(userId: userId);

      if ((res.statusCode ?? 400) > 299) {
        throw Exception('Failed to delete account (Response#statusCode is not 204)');
      }

      successHandler(t.home_settings.success.delete_account);
      ref.read(authProvider).signOut();

      // FIXME: routerProvider の中でリダイレクトを処理する
      final router = ref.read(routerProvider);
      while (router.canPop()) {
        router.pop();
      }
      router.goNamed(SignupPage.name);

      // Social ページがフェッチされてしまうので、clearUser() を遅延させる
      Future.delayed(const Duration(milliseconds: 300), () {
        ref.read(currentUserProvider.notifier).clearUser();
      });

    } on DioException catch (e) {
      final serviceError = safeDeserializeServiceError(e);

      if (serviceError.isOk) {
        errorHandler('${serviceError.ok()!.code}: ${serviceError.ok()!.message}');
      } else {
        errorHandler('${e.message}');
      }

      logger.e('Error deleting account: $e');
    }
  }

  Future<void> openPrivacyPolicyPage() async {
    final url = Uri.parse(Urls.privacyPolicy);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> updateBackgroundLocationSetting({
    required SuccessHandler<String> successHandler,
    required ErrorHandler errorHandler,
}) async {
    final enabled = await ref.read(backgroundLocationEnabledProvider.future);

    try {
      final preferencesService = await ref.read(preferencesServiceProvider.future);

      if (enabled) {
        await disableBackgroundService();
      } else {
        await enableBackgroundService();
      }

      await preferencesService.setBackgroundLocationEnabled(!enabled);
      ref.invalidate(backgroundLocationEnabledProvider);

      successHandler(
        enabled
          ? t.home_settings.success.background_location_disabled
          : t.home_settings.success.background_location_enabled,
      );

    } catch (e) {
      errorHandler(
        enabled
          ? t.home_settings.error.failed_to_disable_background_location
          : t.home_settings.error.failed_to_enable_background_location,
      );
      logger.e('Error updating background location setting: $e');
    }
  }
}
