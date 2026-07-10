class GiftPoint {
  static const int _minPoint = 0;
  final int value;

  GiftPoint(this.value) {
    if (value < _minPoint) {
      throw ArgumentError('GiftPoint value cannot be less than $_minPoint');
    }
  }
}

void main() {
  try {
    final giftPoint = GiftPoint(-5);
  } catch (e) {
    // ignore: avoid_print
    print(e); // Output: GiftPoint value cannot be less than 0
  }

  final standardMemberShipPoint = GiftPoint(3000);
  // ignore: avoid_print
  print(standardMemberShipPoint.value); // Output: 10

  final premiumMemberShipPoint = GiftPoint(5000);

  // ignore: avoid_print
  print(premiumMemberShipPoint.value); // Output: 10
}