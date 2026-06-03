// main.dart
import 'dart:mirrors';
import 'sample9_1.dart';

/// 内容結合の例：リフレクションを使用してプライベートメソッドにアクセスする（下流モジュール）
/// アンチパターンコード
// void main() {
//   // 1. 正常なインスタンス化
//   var myAccount = BankAccount('アリス');
//   myAccount.showBalance(); // 残高: 1000円

//   print('\n--- リフレクションによる内容結合（不正アクセス）を開始 ---');

//   // 2. インスタンスのミラー（鏡）を取得
//   InstanceMirror instanceMirror = reflect(myAccount);

//   // 3. プライベートメソッドの名前をシンボル化
//   // Dartのプライベートは「一意の識別子」として管理されるため、Symbol経由で指定可能
//   Symbol privateMethodName = #_secretWithdraw;

//   // 4. 外部からプライベートメソッドを強制実行（内容結合の発生）
//   // 引数に 800 を渡して呼び出す
//   instanceMirror.invoke(privateMethodName, [800]);

//   print('--- 不正アクセス終了 ---\n');

//   // 5. 結果の確認
//   myAccount.showBalance(); // 残高が 200円 に減っている
// }