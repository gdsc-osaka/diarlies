part of 'page.dart';

@riverpod
SignupAction _signupAction(Ref ref) =>
    SignupAction(ref);

class SignupAction extends FluxAction {
  SignupAction(super.ref);

  Future<void> signInWithGoogle() async {
    final auth = ref.read(authProvider);
    final analytics = ref.read(analyticsProvider);
    final usersApi = ref.read(usersApiProvider);

    try {
      await auth.signOut();

      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);

      analytics.logLogin(loginMethod: 'google');
      ref.read(currentAuthUserProvider.notifier).setUser(userCredential.user);

      logger.i('User signed in with Google: ${userCredential.user?.uid}');

      // idToken の更新を待機
      await Future.delayed(const Duration(milliseconds: 10));

      final res = await usersApi.createUser();
      final user = res.data;

      if (user == null) {
        throw Exception('Failed to create user (Response#data is null)');
      }

      ref.read(currentUserProvider.notifier).setUser(user);
    } on FirebaseAuthException catch (e) {
      logger.e('Failed to sign in with Google: $e');
      return;
    } on DioException catch (e) {
      final serviceError = standardSerializers.deserialize(
        e.response?.data,
        specifiedType: const FullType(CreateUserServiceError),
      ) as CreateUserServiceError;

      if (serviceError.code == CreateUserServiceErrorCodeEnum.userAlreadyExists) {
        final user = serviceError.user;
        if (user == null) {
          throw Exception('error.user must be set');
        }

        ref.read(currentUserProvider.notifier).setUser(user);
        return;
      }

      logger.e('Error creating user: $e');
      return;
    }
  }
}