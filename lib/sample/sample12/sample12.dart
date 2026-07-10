// ignore: dangling_library_doc_comments
/// ファクトリパターン

class GiftPoint {
  static const int _minPoint = 0;
  static const int _standardMembershipPoint = 3000;
  static const int _premiumMembershipPoint = 5000;
  final int value;

  /// 用途別にポイントを生成するために、以下の処理は private constructor を使用
  GiftPoint._(this.value);

  /// 用途別にポイントを生成するために、以下の処理は private factory constructor を使用
  factory GiftPoint._create(int value) {
    if (value < _minPoint) {
      throw ArgumentError('GiftPoint value cannot be less than $_minPoint');
    }
    return GiftPoint._(value);
  }

  factory GiftPoint.standardMembership() {
    return GiftPoint._create(_standardMembershipPoint);
  }

  factory GiftPoint.premiumMembership() {
    return GiftPoint._create(_premiumMembershipPoint);
  }
}

void main() {

  final standardMemberShipPoint = GiftPoint.standardMembership();
  // ignore: avoid_print
  print(standardMemberShipPoint.value); // Output: 3000

  final premiumMemberShipPoint = GiftPoint.premiumMembership();

  // ignore: avoid_print
  print(premiumMemberShipPoint.value); // Output: 5000
}