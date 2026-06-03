// user_view.dart (Presentation層 / 画面)
import 'sample9_3.dart';
import 'sample9_5.dart';

/// 無法地帯と化したPresentation層
class UserView {
  final UserController _controller = UserController();

  // 画面の初期表示
  void renderPage() {
    print('\n--- 画面描画 ---');
    // ReadはController経由
    _controller.handleGetRequest(1); 
    
    // UpdateもController経由（ただしControllerの内部はDB直叩き）
    _controller.handleUpdateRequest(1, 'アリス・イン・ワンダーランド'); 
  }

  // 【最悪の内容結合】「削除ボタン」が押された時の処理
  void onCryptoDeleteButtonClicked(int id) {
    print('\n[Presentation] 🚨超・規約違反: 画面から直接DBの生データを削除します！');
    
    // ControllerもServiceもRepositoryも完全に無視。
    // 画面がDBの仕様（rawTableという変数名やremoveメソッド）に100%依存している
    MockDatabase.rawTable.remove(id);
    
    print('[Presentation] 画面から直接DBのレコードを抹消しました。');
  }
}