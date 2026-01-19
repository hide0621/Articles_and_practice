// ストラテジーパターン適用後（関数型）: 関数を使ってContextで切り替える設計

// ダミー型定義
class Item {}

class Api {
  Future<List<Item>> getItems(String id) async => [];
}

class Cache {
  final Map<String, List<Item>> _cache = {};

  List<Item> get(String id) => _cache[id]!;

  void put(String id, List<Item> items) {
    _cache[id] = items;
  }
}

// 関数の型定義
typedef DataFetcher = Future<List<Item>> Function(String id);

// 各実装
Future<List<Item>> fetchFromApi(String id, Api api) async {
  return await api.getItems(id);
}

Future<List<Item>> fetchFromCache(String id, Cache cache) async {
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

void main() {
  // 切り替え
  final repo1 = DataRepository((id) => fetchFromApi(id, Api()));
  final repo2 = DataRepository((id) => fetchFromCache(id, Cache()));
}
