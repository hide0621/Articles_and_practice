// 1. sealed classを定義
sealed class OrderStatus {
  // 共通のプロパティやメソッドをここに定義
  String get description;

  // 抽象メソッドとして定義し、各サブクラスでの実装を強制
  // 各サブクラスはこの実装により個々の振る舞いを表現することができる
  OrderStatus nextStatus();
}

// 2. sealed classを継承するサブクラスを定義
// これらのサブクラスは、他のファイルからは継承できない
class Pending extends OrderStatus {
  @override
  String get description => '保留中';

  // nextStatusメソッドを実装しなかった場合は以下のようにコンパイルエラーを発生させることができる
  // 「Missing concrete implementation of 'OrderStatus.nextStatus'.
  // Try implementing the missing method, or make the class abstract.」
  @override
  OrderStatus nextStatus() => Processing();
}

class Processing extends OrderStatus {
  @override
  String get description => '処理中';

  // nextStatusメソッドを実装しなかった場合は以下のようにコンパイルエラーを発生させることができる
  // 「Missing concrete implementation of 'OrderStatus.nextStatus'.
  // Try implementing the missing method, or make the class abstract.」
  @override
  OrderStatus nextStatus() => Shipped();
}

class Shipped extends OrderStatus {
  @override
  String get description => '発送済み';

  // nextStatusメソッドを実装しなかった場合は以下のようにコンパイルエラーを発生させることができる
  // 「Missing concrete implementation of 'OrderStatus.nextStatus'.
  // Try implementing the missing method, or make the class abstract.」
  @override
  OrderStatus nextStatus() => Delivered();
}

class Delivered extends OrderStatus {
  @override
  String get description => '配達済み';

  // nextStatusメソッドを実装しなかった場合は以下のようにコンパイルエラーを発生させることができる
  // 「Missing concrete implementation of 'OrderStatus.nextStatus'.
  // Try implementing the missing method, or make the class abstract.」
  @override
  OrderStatus nextStatus() => this; // 最終ステータス
}

// 3. switch文でパターンマッチングと網羅性チェックを活用
String getStatusDescription(OrderStatus status) {
  return switch (status) {
    Pending() => 'ご注文はまだ処理されていません。',
    Processing() => 'ご注文を処理中です。',
    Shipped() => 'ご注文は発送されました。',
    Delivered() => 'ご注文は配達済みです。',
    // Canceled() という新しいクラスを追加すると、
    // ここで網羅性エラーが発生する！
  };
}

void main() {
  OrderStatus status = Pending();
  print('現在のステータス: ${getStatusDescription(status)}'); // `switch`文の活用

  status = status.nextStatus(); // クラスの固有メソッドを活用
  print('次のステータス: ${getStatusDescription(status)}');
}
