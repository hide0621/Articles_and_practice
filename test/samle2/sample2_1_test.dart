import 'package:articles_and_practice/sample2/sample2_1.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isStringLongメソッドのテスト', () {
    test('5文字以下ならfalseになる', () {
      expect(isStringLong('abcde'), isFalse);
    });

    test('6文字以上ならtrueになる', () {
      expect(isStringLong('abcdef'), isTrue);
    });
  });
}