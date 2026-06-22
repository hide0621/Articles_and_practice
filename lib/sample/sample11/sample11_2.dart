/// 状態（データ）とそれを操作するロジックが一体となった高凝集なクラス
/// クラス内部で見れば「共通結合」の構造（同じプロパティを複数メソッドが触る）だが、
/// 密結合による弊害がクラス内に閉じ込められているため、優れた設計のパターン。
class ShoppingCart {
  // 共通のプロパティ（外部からは隠蔽されている：カプセル化）
  final List<String> _items = [];
  double _totalPrice = 0.0;

  // 操作メソッド1: 共通プロパティを参照・更新
  void addItem(String item, double price) {
    _items.add(item);
    _totalPrice += price; 
  }

  // 操作メソッド2: 共通プロパティを参照・更新
  void removeItem(String item, double price) {
    if (_items.remove(item)) {
      _totalPrice -= price;
    }
  }

  // 外部へは安全に公開
  double get totalPrice => _totalPrice;
  List<String> get items => List.unmodifiable(_items);
}