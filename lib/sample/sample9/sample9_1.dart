// 内容結合させる対象コンポーネント（上流モジュール）
class BankAccount {
  String owner;
  int _balance = 1000; // プライベート変数

  BankAccount(this.owner);

  // 本来は外部から直接呼ばれてはいけないプライベートメソッド
  void _secretWithdraw(int amount) {
    _balance -= amount;
    print('[Internal] $amount 円が隠れて引き出されました。残高: $_balance 円');
  }

  void showBalance() {
    print('$owner さんの現在の公表残高: $_balance 円');
  }
}