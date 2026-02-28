// !A && !Bの状態

// class Article {
//   bool isDraft;
//   bool isDeleted;
//   String content;

//   Article(this.isDraft, this.isDeleted, this.content);

//   void publish() {
//     // !A && !B の状態。否定が連続していて直感的でない
//     if (!isDraft && !isDeleted) {
//       print('記事を公開: $content');
//     } else {
//       print('公開できません');
//     }
//   }
// }

// !A && !B の状態を整理して、!(A || B) の状態を表すコード
// ド・モルガンの法則を適用

class Article {
  bool isDraft;
  bool isDeleted;
  String content;

  Article(this.isDraft, this.isDeleted, this.content);

  void publish() {
    // !(A || B) の状態。
    // 「公開不可な状態（isUnpublishable）」の【否定】として読めるようになる
    if (!_isUnpublishable()) {
      print('記事を公開: $content');
    } else {
      print('公開できません');
    }
  }

  // 抽出した関数：肯定的な条件（OR）にまとまったことでロジックが明快に
  bool _isUnpublishable() {
    return isDraft || isDeleted;
  }
}

// !A || !B の状態
class User {
  bool hasValidCard;
  bool hasSufficientBalance;

  User(this.hasValidCard, this.hasSufficientBalance);
}

class PaymentProcessor {
  void process(User user) {
    // !A || !B の状態。条件が複雑に感じる
    if (!user.hasValidCard || !user.hasSufficientBalance) {
      throw Exception('決済に失敗しました。カード情報または残高を確認してください。');
    }

    // 以降、決済の正常系ロジック...
    print('決済完了');
  }
}
