// ストラテジーパターン適用後:
// キャッシュ機能は具象クラスに分離させ、Cotextで切り替え可能にする設計
// かつ、インターフェース分離の原則を適用し、必要なメソッドのみを持つインターフェースに分けている

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

// 実装1: キャッシュ付き
class CachedDataFetchStrategy implements CacheableDataFetchStrategy {
  CachedDataFetchStrategy({required this.api});

  final Api api;

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
    final data = await api.getItems(id);
    _cache[id] = data;
    return data;
  }

  @override
  void clearCache() {
    _cache.clear();
  }
}

// 実装2: 直接取得
class DirectDataFetchStrategy implements DataFetchStrategy {
  DirectDataFetchStrategy({required this.api});

  final Api api;

  @override
  bool get isReady => true;

  @override
  Future<List<Item>> fetch(String id) async {
    return await api.getItems(id);
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
  final repo1 = DataRepository(CachedDataFetchStrategy(api: Api()));
  final repo2 = DataRepository(DirectDataFetchStrategy(api: Api()));
}
