// ストラテジーパターン適用後（合成パターン）:
// キャッシュ機能は具象クラスに分離させ、Cotextで切り替え可能にする設計
// かつ、インターフェース分離の原則を適用し、必要なメソッドのみを持つインターフェースに分ける
// かつ、継承ではなく合成によって共通機能を再利用する

// ダミー型定義
class Item {}

class Api {
  Future<List<Item>> getItems(String id) async => [];
}

// Strategy インターフェース（基本）
abstract interface class DataFetchStrategy {
  Future<List<Item>> fetch(String id);
  bool get isReady;
}

// キャッシュ機能を持つStrategy用のインターフェース
abstract interface class CacheableDataFetchStrategy
    implements DataFetchStrategy {
  void clearCache();
}

// 基本実装: 共通機能を提供するベースクラス
class BaseDataFetchStrategy implements DataFetchStrategy {
  BaseDataFetchStrategy();

  final _api = Api();

  @override
  bool get isReady => true;

  @override
  Future<List<Item>> fetch(String id) async {
    return await _api.getItems(id);
  }
}

// 実装1: キャッシュ付き（合成 + ISPを使用）
class CachedDataFetchStrategy implements CacheableDataFetchStrategy {
  CachedDataFetchStrategy();

  // 合成: 基本機能を持つクラスをプライベートフィールドとして保持
  final BaseDataFetchStrategy _baseStrategy = BaseDataFetchStrategy();
  final Map<String, List<Item>> _cache = {};
  bool _initialized = false;

  @override
  bool get isReady => _initialized;

  void initialize() {
    _initialized = true;
  }

  @override
  Future<List<Item>> fetch(String id) async {
    if (_cache.containsKey(id)) {
      return _cache[id]!;
    }
    // 基本機能を委譲
    final data = await _baseStrategy.fetch(id);
    _cache[id] = data;
    return data;
  }

  @override
  void clearCache() {
    _cache.clear();
  }
}

// 実装2: 直接取得（合成を使用）
class DirectDataFetchStrategy implements DataFetchStrategy {
  DirectDataFetchStrategy();

  // 合成: 基本機能を持つクラスをプライベートフィールドとして保持
  final BaseDataFetchStrategy _baseStrategy = BaseDataFetchStrategy();

  @override
  bool get isReady => _baseStrategy.isReady;

  @override
  Future<List<Item>> fetch(String id) async {
    // 基本機能を委譲
    return _baseStrategy.fetch(id);
  }
}

// 使用例
class DataRepository {
  DataRepository(this.strategy);

  final DataFetchStrategy strategy;

  Future<List<Item>> getData(String id) async {
    if (!strategy.isReady) {
      throw StateError('Strategy not ready');
    }
    return strategy.fetch(id);
  }

  void refresh() {
    // キャッシュ機能を持つストラテジーの場合のみクリア
    switch (strategy) {
      case CacheableDataFetchStrategy s:
        s.clearCache();
      default:
        throw UnsupportedError('Strategy does not support cache operations');
    }
  }
}

void main() {
  // 切り替え
  final cachedStrategy = CachedDataFetchStrategy();
  cachedStrategy.initialize();
  final repo1 = DataRepository(cachedStrategy);
  final repo2 = DataRepository(DirectDataFetchStrategy());
}
