// ignore: dangling_library_doc_comments
/// メッセージ結合の例
// class Caller {
//   final Closable closable;
//   Caller(this.closable);

//   void doSomething() {
//     closable.close();
//   }
// }

// class Caller {
//   final UserListPresenter _userListPresenter;
//   Caller({UserListPresenter userListPresenter}) : _userListPresenter = userListPresenter;

//   void updateUserList() {
//     final users = ...
//     userListPresenter.users = users;
//     ...
//     userListPresenter.notifyUserListUpdated();
//   }
// }