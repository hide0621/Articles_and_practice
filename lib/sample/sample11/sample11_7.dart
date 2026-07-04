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

// ignore: dangling_library_doc_comments
/// 表面的にはメッセージ結合だが、実質はデータ結合になっていて、斜め読みもしにくい例

// class Caller {
//   final ErrorViewPresenter _errorViewPresenter;
//   Caller({ErrorViewPresenter errorViewPresenter}) : _errorViewPresenter = errorViewPresenter;

//   void updateViews() {
//     var result = ...;
//     ...
//     var isErrorViewVisible = result.isError;
//     if (isErrorViewVisible) {
//       _errorViewPresenter.showErrorView();
//     } else {
//       _errorViewPresenter.hideErrorView();
//     }
//   }
// }

// class ErrorViewPresenter {
//   ...
//   void showErrorView() {
//     view.isVisible = true;
//   }

//   void hideErrorView() {
//     view.isVisible = false;
//   }
// }

// ignore: dangling_library_doc_comments
/// データ結合にして斜め読みもしやすくした例

// class Caller {
//   ...
//   void updateViews() {
//     var result = ...;
//     ...
//     var isErrorViewVisible = result.isError;
//     _errorViewPresenter.setErrorViewVisibility(isErrorViewVisible);
//   }
// }

// class ErrorViewPresenter {
//   ...
//   void setErrorViewVisibility(bool isVisible) {
//     view.isVisible = isVisible;
//   }
// }