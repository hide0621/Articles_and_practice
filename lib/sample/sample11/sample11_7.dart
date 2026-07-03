// ignore: dangling_library_doc_comments
/// メッセージ結合の例
// class Caller {
//   final Closable closable;
//   Caller(this.closable);

//   void doSomething() {
//     closable.close();
//   }
// }

// ignore: dangling_library_doc_comments
/// 内容結合を含むメッセージ結合の例

// class Caller {
//   final UserListPresenter _userListPresenter;
//   Caller({UserListPresenter userListPresenter}) : _userListPresenter = userListPresenter;

//   void updateUserList() {
//     final users = ...
//     _userListPresenter.users = users;
//     ...
//     _userListPresenter.notifyUserListUpdated();
//   }
// }

// ignore: dangling_library_doc_comments
/// リファクタリング後

// class Caller {
//   final UserListPresenter _userListPresenter;
//   Caller({UserListPresenter userListPresenter}) : _userListPresenter = userListPresenter;

//   void updateUserList() {
//     final users = ...
//     _userListPresenter.notifyUserListUpdated(users);
//   }
// }