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

// ストラテジーパターン適用後: 
// キャッシュ機能は具象クラスに分離させ、Cotextで切り替え可能にする設計
// かつ、インターフェース分離の原則を適用し、必要なメソッドのみを持つインターフェースに分けている
// Strategy インターフェース（基本）
abstract interface class DataFetchStrategy {
  Future<List<Item>> fetch(String id);
  bool get isReady;
}

// キャッシュ機能を持つStrategy用のインターフェース
abstract interface class CacheableDataFetchStrategy implements DataFetchStrategy {
  void clearCache();
}

// 実装1: キャッシュ付き
class CachedDataFetchStrategy implements CacheableDataFetchStrategy {
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

// 切り替え
final repo1 = DataRepository(CachedDataFetchStrategy());
final repo2 = DataRepository(DirectDataFetchStrategy());

// ストラテジーパターン適用後（関数型）: 関数を使ってContextで切り替える設計
// 関数の型定義
typedef DataFetcher = Future<List<Item>> Function(String id);

// 各実装
Future<List<Item>> fetchFromApi(String id) async {
  return await api.getItems(id);
}

Future<List<Item>> fetchFromCache(String id) async {
  return cache.get(id);
}

// 使用例
class DataRepository {
  DataRepository(this.fetcher);

  final DataFetcher fetcher;

  Future<List<Item>> getData(String id) {
    return fetcher(id);
  }
}

// 切り替え
final repo1 = DataRepository(fetchFromApi);
final repo2 = DataRepository(fetchFromCache);


// ストラテジーパターン適用後（合成パターン適用版）: 
// キャッシュ機能は具象クラスに分離させ、Cotextで切り替え可能にする設計
// 継承ではなく、合成によって共通機能を再利用する

// Strategy インターフェース
abstract interface class DataFetchStrategy {
  Future<List<Item>> fetch(String id);
  void clearCache();
  bool get isReady;
}

// 基本実装: 共通機能を提供するベースクラス
class BaseDataFetchStrategy implements DataFetchStrategy {
  BaseDataFetchStrategy();

  @override
  bool get isReady => true;

  @override
  Future<List<Item>> fetch(String id) async {
    return await api.getItems(id);
  }

  @override
  void clearCache() {
    // デフォルトでは何もしない
  }
}

// 実装1: キャッシュ付き（合成を使用）
class CachedDataFetchStrategy implements DataFetchStrategy {
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

  @override
  void clearCache() {
    // 基本機能を委譲
    _baseStrategy.clearCache();
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

// ストラテジーパターン適用後（関数型）: 関数を使ってContextで切り替える設計
// 関数の型定義
typedef DataFetcher = Future<List<Item>> Function(String id);

// 各実装
Future<List<Item>> fetchFromApi(String id) async {
  return await api.getItems(id);
}

Future<List<Item>> fetchFromCache(String id) async {
  return cache.get(id);
}

// 使用例
class DataRepository {
  DataRepository(this.fetcher);

  final DataFetcher fetcher;

  Future<List<Item>> getData(String id) {
    return fetcher(id);
  }
}

// 切り替え
final repo1 = DataRepository(fetchFromApi);
final repo2 = DataRepository(fetchFromCache);

// ストラテジーパターン適用後（合成パターン）: 
// キャッシュ機能は具象クラスに分離させ、Cotextで切り替え可能にする設計
// かつ、インターフェース分離の原則を適用し、必要なメソッドのみを持つインターフェースに分ける
// かつ、継承ではなく合成によって共通機能を再利用する

// Strategy インターフェース（基本）
abstract interface class DataFetchStrategy {
  Future<List<Item>> fetch(String id);
  bool get isReady;
}

// キャッシュ機能を持つStrategy用のインターフェース
abstract interface class CacheableDataFetchStrategy implements DataFetchStrategy {
  void clearCache();
}

// 基本実装: 共通機能を提供するベースクラス
class BaseDataFetchStrategy implements DataFetchStrategy {
  BaseDataFetchStrategy();

  @override
  bool get isReady => true;

  @override
  Future<List<Item>> fetch(String id) async {
    return await api.getItems(id);
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

// 切り替え
final cachedStrategy = CachedDataFetchStrategy();
cachedStrategy.initialize();
final repo1 = DataRepository(cachedStrategy);
final repo2 = DataRepository(DirectDataFetchStrategy());
