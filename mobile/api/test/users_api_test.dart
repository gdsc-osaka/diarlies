import 'package:test/test.dart';
import 'package:api/api.dart';


/// tests for UsersApi
void main() {
  final instance = Api().getUsersApi();

  group(UsersApi, () {
    // 新しいユーザーを作成
    //
    // 新しいユーザーをシステムに登録します。
    //
    //Future<User> createUser(NewUser newUser) async
    test('test createUser', () async {
      // TODO
    });

    // 特定のユーザー情報を取得
    //
    //Future<User> getUserById(String userId) async
    test('test getUserById', () async {
      // TODO
    });

    // ユーザーリストを取得
    //
    // 登録されているユーザーのリストを返します。
    //
    //Future<BuiltList<User>> getUsers({ int limit, int offset }) async
    test('test getUsers', () async {
      // TODO
    });

  });
}
