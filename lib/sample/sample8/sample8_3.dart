/// アダプターパターンのアンチパターン

// protoc によって生成されたコードを想定（編集すべきでない領域）
class UserProto {
  // フィールド名が少々長くて気に入らないとする
  String user_full_name;
  int created_at_epoch_seconds;

  UserProto({
    required this.user_full_name,
    required this.created_at_epoch_seconds,
  });
}

/// 「短い名前で扱いたいから」という理由だけで作られたラッパー。
// アプリが使いたい「好みのインターフェース」
class User {
  final String name;
  final DateTime createdAt;

  User({
    required this.name,
    required this.createdAt,
  });
}

// gRPC / REST 通信用の Adapter（アンチパターン例）
class UserProtoAdapter {
  // Proto -> App Model
  User fromProto(UserProto proto) {
    return User(
      name: proto.user_full_name,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        proto.created_at_epoch_seconds * 1000,
      ),
    );
  }

  // App Model -> Proto
  UserProto toProto(User user) {
    return UserProto(
      user_full_name: user.name,
      created_at_epoch_seconds:
          (user.createdAt.millisecondsSinceEpoch / 1000).round(),
    );
  }
}

/// 自動テストはこんな感じ
/// この自動テストも本来は不要であり、余計なメンテナンスコスト、テストへの信頼性の悪化や認知負荷の増加を招くことになる。
// import 'package:test/test.dart';

// void main() {
//   group('UserProtoAdapter (アンチパターン例)', () {
//     test('fromProto はフィールドを正しくマッピングできる', () {
//       final proto = UserProto(
//         user_full_name: 'Alice Smith',
//         created_at_epoch_seconds: 1_700_000_000,
//       );

//       final adapter = UserProtoAdapter();
//       final user = adapter.fromProto(proto);

//       expect(user.name, 'Alice Smith');
//       expect(
//         user.createdAt.millisecondsSinceEpoch,
//         proto.created_at_epoch_seconds * 1000,
//       );
//     });

//     test('toProto はフィールドを正しくマッピングできる', () {
//       final createdAt = DateTime.fromMillisecondsSinceEpoch(1_700_000_000 * 1000);
//       final user = User(
//         name: 'Bob Lee',
//         createdAt: createdAt,
//       );

//       final adapter = UserProtoAdapter();
//       final proto = adapter.toProto(user);

//       expect(proto.user_full_name, 'Bob Lee');
//       expect(
//         proto.created_at_epoch_seconds,
//         (createdAt.millisecondsSinceEpoch / 1000).round(),
//       );
//     });
//   });
// }