/// 基礎となるDBとDomain層

// database.dart (外部インターフェース)
class MockDatabase {
  // どこからでもアクセスできてしまうデータ（行データ）を擬似的に表現
  static final Map<int, Map<String, dynamic>> rawTable = {
    1: {'id': 1, 'name': 'アリス', 'role': 'Admin'},
    2: {'id': 2, 'name': 'ボブ', 'role': 'User'},
  };
}

// user_domain.dart (Domain層)
class User {
  final int id;
  final String name;
  final String role;
  User({required this.id, required this.name, required this.role});
}