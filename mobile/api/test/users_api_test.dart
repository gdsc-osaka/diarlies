import 'package:test/test.dart';
import 'package:api/api.dart';


/// tests for UsersApi
void main() {
  final instance = Api().getUsersApi();

  group(UsersApi, () {
    // Change user visibility
    //
    //Future<User> changeUserVisibility(String userId, ChangeUserVisibilityRequest changeUserVisibilityRequest) async
    test('test changeUserVisibility', () async {
      // TODO
    });

    // Create a new user
    //
    //Future<User> createUser() async
    test('test createUser', () async {
      // TODO
    });

    // Get user information
    //
    //Future<User> getUser() async
    test('test getUser', () async {
      // TODO
    });

  });
}
