// // ストラテジーパターン適用前: キャッシュ機能の切り替えはフラグで管理する設計
// class DataRepository {
//   final Map<String, List<Item>> _cache = {};
//   bool _useCache = true;
//   bool _initialized = false;

//   bool get isReady => _initialized;

//   void initialize() {
//     _initialized = true;
//   }

//   void setUseCache(bool useCache) {
//     _useCache = useCache;
//   }

//   Future<List<Item>> getData(String id) async {
//     if (!_initialized) {
//       throw StateError('Repository not initialized');
//     }

//     if (_useCache && _cache.containsKey(id)) {
//       return _cache[id]!;
//     }

//     final data = await api.getItems(id);

//     if (_useCache) {
//       _cache[id] = data;
//     }

//     return data;
//   }

//   void clearCache() {
//     _cache.clear();
//   }
// }

// // 使用例
// final repo = DataRepository();
// repo.initialize();
// repo.setUseCache(true); // キャッシュを使う
// // または
// repo.setUseCache(false); // 直接取得

// ストラテジーパターン適用後: キャッシュ機能は具象クラスに分離させ、Cotextで切り替え可能にする設計
// Strategy インターフェース
abstract interface class DataFetchStrategy {
  Future<List<Item>> fetch(String id);
  void clearCache();
  bool get isReady;
}

// 実装1: キャッシュ付き
class CachedDataFetchStrategy implements DataFetchStrategy {
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
  @override
  bool get isReady => true;

  @override
  Future<List<Item>> fetch(String id) async {
    return await api.getItems(id);
  }

  @override
  void clearCache() {
    // 何もしない
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
    strategy.clearCache();
  }
}

// 切り替え
final repo1 = DataRepository(CachedDataFetchStrategy());
final repo2 = DataRepository(DirectDataFetchStrategy());
