// // ignore: dangling_library_doc_comments
// /// 外部結合に設計上のアンチパターン

// // ignore: avoid_init_to_null
// int? parameter = null;

// // ignore: avoid_init_to_null
// int? result = null;

// class Calculator {
//    int calculate() {
//     if (parameter == null) {
//       throw Exception('parameter is null');
//     }
//     result = parameter! * 2;
//     return result!;
//   }
// }

// class Caller {
//   final Calculator calculator;

//   Caller(this.calculator);

//   void callCalculator() {
//     parameter = 5; 
//     print(calculator.calculate());
//   }
// }

// ignore: dangling_library_doc_comments
/// 外部結合を引数と戻り値を用いて解消した例

class Calculator {
  int calculate(int parameter) {
    return parameter * 2;
  }
}

class Caller {
  final Calculator calculator;

  Caller(this.calculator);

  void callCalculator() {
    final result = calculator.calculate(5);
    // ignore: avoid_print
    print(result);
  }
}