// user_controller.dart (Controller層)
import 'sample9_3.dart';
import 'sample9_4.dart';

/// ルールを破り始めたController層
class UserController {
  final UserService _service = UserService();

  // 【正常ルート】ReadはちゃんとService -> Repository経由で呼ぶ
  void handleGetRequest(int id) {
    final user = _service.getUser(id);
    if (user != null) {
      print('[Controller] ユーザーが見つかりました: ${user.name}');
    }
  }

  // 【内容結合】Updateはあろうことか、DBのテーブルを直接書き換える！
  void handleUpdateRequest(int id, String newName) {
    print('[Controller] ⚠️規約違反: Service/RepositoryをバイパスしてDBを直接書き換えます');
    
    if (MockDatabase.rawTable.containsKey(id)) {
      // DBの「内部構造（Mapのキーや構造）」をControllerが完全に知ってしまっている（内容結合）
      MockDatabase.rawTable[id]!['name'] = newName; 
      print('[Controller] DBの生データを直接更新しました。');
    }
  }
}