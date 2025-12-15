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
