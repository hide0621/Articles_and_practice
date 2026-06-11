// bool isStringLong(String str) {
//   if (str.length > 5) {
//     return true;
//   } 
//   return false;
// }

// bool isStringLong(String str) {
//   return str.length > 5 ? true : false;
// }

class Message {
  bool? result;

  Message({this.result});

  bool isStringLong(String str) {
    if (str.length > 5) {
      result = true;
      return true;
    }
    result = false;
    return false;
  }
}