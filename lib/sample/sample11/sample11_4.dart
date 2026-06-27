// ignore: dangling_library_doc_comments
/// 制御結合の例

// void updateView(bool isError) {
//   if (isError) {
//     resultView.isVisible = true;
//     errorView.isVisible = false;
//     iconView.image = CROSS_ICON;
//   } else {
//     resultView.isVisible = false;
//     errorView.isVisible = true;
//     iconView.image = CHECK_ICON;
//   }
// }

// ignore: dangling_library_doc_comments
/// 制御結合を「操作対象による分割」でリファクタリングした例

// void updateView(bool isError) {
//   resultView.isVisible = !isError;
//   errorView.isVisible = isError;
//   iconView.image = getIconImage(isError);
// }

// Image getIconImage(bool isError) {
//   return isError ? CROSS_ICON : CHECK_ICON;
// }

// ignore: dangling_library_doc_comments
/// 制御結合の例

// class ProfileViewPresenter {
//   void updateUserView(DateType dateType) {
//     switch (dateType) {
//       case DateType.userName:
//         var userName = getUserName(dateType.userId);
//         userNameView.text = userName;
//         break;
//       case DateType.birthDate:
//         var birthDate = formatBirthDate(dateType.birthDate);
//         birthDateView.text = birthDate;
//         break;
//       case DateType.ProfileImage:
//         var profileImageBitmap = getProfileImageBitmap(dateType.userId);
//         profileImageView.image = profileImageBitmap;
//         break;
//     }
//   }
// }

// ignore: dangling_library_doc_comments
/// 上記、制御結合が引き起こす呼び出し元のパターンの例
// class Caller {
//   void callUpateUserView() {
//     switch (dateType) {
//       case satisfiesCondition:
//         var dateType = DateType.userName;
//         profileViewPresenter.updateUserView(dateType);
//         break;
//       case satisfiesAnotherCondition:
//         var dateType = DateType.birthDate;
//         profileViewPresenter.updateUserView(dateType);
//         break;
//       case satisfiesYetAnotherCondition:
//         var dateType = DateType.ProfileImage;
//         profileViewPresenter.updateUserView(dateType);
//         break;
//     }
//   }
// }

// ignore: dangling_library_doc_comments
/// 条件分岐内の処理に関連性がない制御結合を関心ごとに分割した例

// class ProfileViewPresenter {
//   void updateUserView() {
//     var userName = getUserName();
//     userNameView.text = userName;
//   }

//   void updateBirthDateView() {
//     var birthDate = formatBirthDate();
//     birthDateView.text = birthDate;
//   }

//   void updateProfileImageView() {
//     var profileImageBitmap = getProfileImageBitmap();
//     profileImageView.image = profileImageBitmap;
//   }
// }

// class Caller1 {
//   void someMethod() {
//     profileViewPresenter.updateUserView();
//   }
// }

// class Caller2 {
//   void someMethod() {
//     profileViewPresenter.updateBirthDateView();
//   }
// }

// class Caller3 {
//   void someMethod() {
//     profileViewPresenter.updateProfileImageView();
//   }
// }