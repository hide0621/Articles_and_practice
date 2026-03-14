/// アダプターパターン適用前

/// 修正前

// 既存ライブラリ側（変更できないとする）
class LegacyLogger {
  void logMessage(String message) {
    print('[LEGACY] $message');
  }
}

// 新しいコード側
class UserService {
  final LegacyLogger _logger;

  UserService(this._logger);

  void createUser(String name) {
    _logger.logMessage('Creating user: $name');
    // ここにユーザ作成処理...
  }
}

void main() {
  final service = UserService(LegacyLogger());
  service.createUser('Alice');
}
