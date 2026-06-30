// ignore: dangling_library_doc_comments
/// スタンプ結合の例

// 注文を表すデータ構造（実装詳細）
class Order {
  final String id;
  final int totalPrice;
  final String shippingAddress;
  final DateTime orderedAt;

  Order({
    required this.id,
    required this.totalPrice,
    required this.shippingAddress,
    required this.orderedAt,
  });
}

// ----------------------------------------------------
// 結合度：スタンプ結合
// ----------------------------------------------------
// 領収書テキストを作るだけなのに、Orderクラスという「データ構造」を丸ごと受け取っている。
// 内部では totalPrice 以外のプロパティ（idやアドレスなど）を全く使っていない。
String generateReceiptText(Order order) {
  return 'お買い上げ金額は: ￥${order.totalPrice} です。';
}

void main() {
  final myOrder = Order(
    id: 'ORD-123',
    totalPrice: 5500,
    shippingAddress: '福岡県博多区...',
    orderedAt: DateTime.now(),
  );

  // 関数を呼び出すために、Orderのインスタンス（構造）が必要
  final receipt = generateReceiptText(myOrder);
  // ignore: avoid_print
  print(receipt);
}