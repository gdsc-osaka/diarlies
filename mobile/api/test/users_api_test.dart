import 'package:test/test.dart';
import 'package:api/api.dart';


/// tests for UsersApi
void main() {
  final instance = Api().getUsersApi();

  group(UsersApi, () {
    // Get user information
    //
    //Future<User> getUsers() async
    test('test getUsers', () async {
      // TODO
    });

    // Create a new user
    //
    //Future<User> postUsers() async
    test('test postUsers', () async {
      // TODO
    });

  });
}
