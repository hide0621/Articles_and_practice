/// 定価クラス
class RegularPrice {
  int amount;

  static const int _MIN_AMOUNT = 100;

  RegularPrice._internal(this.amount);

  factory RegularPrice.create(int amount) {
    if (amount < _MIN_AMOUNT) {
      throw ArgumentError('Amount must be at least $_MIN_AMOUNT');
    }
    return RegularPrice._internal(amount);
  }
}

/// 通常割引価格クラス
class RgularDiscountedPrice {
  int amount;

  static const int _MIN_AMOUNT = 0;
  static const int _DISCOUNT_AMOUNT = 400;

  RgularDiscountedPrice._internal(this.amount);

  factory RgularDiscountedPrice.create(RegularPrice regularPrice) {
    int discountedAmount = regularPrice.amount - _DISCOUNT_AMOUNT;
    if (discountedAmount < _MIN_AMOUNT) {
      discountedAmount = _MIN_AMOUNT;
    }
    return RgularDiscountedPrice._internal(discountedAmount);
  }
}

/// 夏季割引価格クラス
class SummerDiscountedPrice {
  int amount;

  static const int _MIN_AMOUNT = 0;
  static const int _DISCOUNT_AMOUNT = 300;

  SummerDiscountedPrice._internal(this.amount);

  factory SummerDiscountedPrice.create(RegularPrice regularPrice) {
    int discountedAmount = regularPrice.amount - _DISCOUNT_AMOUNT;
    if (discountedAmount < _MIN_AMOUNT) {
      discountedAmount = _MIN_AMOUNT;
    }
    return SummerDiscountedPrice._internal(discountedAmount);
  }
}