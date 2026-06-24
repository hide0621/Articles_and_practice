// ignore: dangling_library_doc_comments
/// 外部結合に設計上のアンチパターン

// ignore: avoid_init_to_null
int? parameter = null;

// ignore: avoid_init_to_null
int? result = null;

class Calculator {
   int calculate() {
    if (parameter == null) {
      throw Exception('parameter is null');
    }
    result = parameter! * 2;
    return result!;
  }
}

class Caller {
  final Calculator calculator;

  Caller(this.calculator);

  void callCalculator() {
    parameter = 5; 
    print(calculator.calculate());
  }
}