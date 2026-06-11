import 'package:articles_and_practice/sample2/sample2_1.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isStringLongメソッドのテスト', () {
    test('5文字以下ならfalseになる', () {
      final message = Message();
      expect(message.isStringLong('abcde'), isFalse);
      expect(message.result, isFalse);
    });

    test('6文字以上ならtrueになる', () {
      final message = Message();
      expect(message.isStringLong('abcdef'), isTrue);
      expect(message.result, isTrue);
    });
  });
}