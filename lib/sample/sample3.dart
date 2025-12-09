// ストラテジーパターン適用前: キャッシュ機能の切り替えはフラグで管理する設計
class DataRepository {
  final Map<String, List<Item>> _cache = {};
  bool _useCache = true;
  bool _initialized = false;

  bool get isReady => _initialized;

  void initialize() {
    _initialized = true;
  }

  void setUseCache(bool useCache) {
    _useCache = useCache;
  }

  Future<List<Item>> getData(String id) async {
    if (!_initialized) {
      throw StateError('Repository not initialized');
    }

    if (_useCache && _cache.containsKey(id)) {
      return _cache[id]!;
    }

    final data = await api.getItems(id);
    
    if (_useCache) {
      _cache[id] = data;
    }
    
    return data;
  }

  void clearCache() {
    _cache.clear();
  }
}

// 使用例
final repo = DataRepository();
repo.initialize();
repo.setUseCache(true); // キャッシュを使う
// または
repo.setUseCache(false); // 直接取得
