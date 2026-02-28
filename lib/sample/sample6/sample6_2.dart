// !A && !Bの状態

class Article {
  bool isDraft;
  bool isDeleted;
  String content;

  Article(this.isDraft, this.isDeleted, this.content);

  void publish() {
    // !A && !B の状態。否定が連続していて直感的でない
    if (!isDraft && !isDeleted) {
      print('記事を公開: $content');
    } else {
      print('公開できません');
    }
  }
}
