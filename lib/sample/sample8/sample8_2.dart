/// アダプターパターン適用後

/// 修正後

// 変更できない既存ライブラリ
class LegacyLogger {
  void logMessage(String message) {
    print('[LEGACY] $message');
  }
}

// 新たに定義するターゲットインターフェース（アプリが期待する形）
abstract interface class Logger {
  void info(String message);
}

// Adaptee(LegacyLogger) を Target(Logger) に合わせる Adapter
class LegacyLoggerAdapter implements Logger {
  final LegacyLogger _legacy;

  LegacyLoggerAdapter(this._legacy);

  @override
  void info(String message) {
    // ここでインターフェースの差異を吸収
    _legacy.logMessage(message);
  }
}

// アプリ側コードは Logger にだけ依存
class UserService {
  final Logger _logger;

  UserService(this._logger);

  void createUser(String name) {
    _logger.info('Creating user: $name');
    // ユーザ作成処理...
  }
}

void main() {
  final logger = LegacyLoggerAdapter(LegacyLogger());
  final service = UserService(logger);
  service.createUser('Alice');
}
