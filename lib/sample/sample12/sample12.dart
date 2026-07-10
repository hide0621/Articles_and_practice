class GiftPoint {
  static const int _minPoint = 0;
  final int value;

  GiftPoint(this.value) {
    if (value < _minPoint) {
      throw ArgumentError('GiftPoint value cannot be less than $_minPoint');
    }
  }
}