// user_repository.dart (Repository層)
import 'sample9_3.dart';

/// 正気を保っているRepository層とService層
class UserRepository {
  // 【健全な処理】R: IDでユーザーを取得（DBからモデルへ変換）
  User? findById(int id) {
    print('[Repository] DBからデータを安全に取得中...');
    final data = MockDatabase.rawTable[id];
    if (data == null) return null;
    return User(id: data['id'], name: data['name'], role: data['role']);
  }
}

// user_service.dart (Service層)
class UserService {
  final UserRepository _repository = UserRepository();

  User? getUser(int id) {
    return _repository.findById(id);
  }
}