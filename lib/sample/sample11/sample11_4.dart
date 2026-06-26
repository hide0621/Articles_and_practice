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