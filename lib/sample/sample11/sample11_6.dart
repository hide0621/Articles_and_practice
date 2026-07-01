// ignore: dangling_library_doc_comments
/// データ結合の例

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
// 結合度：データ結合
// ----------------------------------------------------
// 必要な最小限の情報（intというプリミティブ型）だけを共有して通信している。
// 呼び出し元の「Order」というデータ構造の実装詳細は一切関知しない。
String generateReceiptTextPure(int price) {
  return 'お買い上げ金額は: ￥$price です。';
}

void main() {
  final myOrder = Order(
    id: 'ORD-123',
    totalPrice: 5500,
    shippingAddress: '福岡県博多区...',
    orderedAt: DateTime.now(),
  );

  // 呼び出し側が構造をバラして、純粋な「値」だけを渡す
  final receipt = generateReceiptTextPure(myOrder.totalPrice);
  // ignore: avoid_print
  print(receipt);
}