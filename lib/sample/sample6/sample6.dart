// A*B + A*C の状態を表すコード

class Order {
  bool isPremiumMember;
  int cartTotal;
  bool hasCoupon;

  Order(this.isPremiumMember, this.cartTotal, this.hasCoupon);

  bool isFreeShipping() {
    // A*B + A*C の状態
    if ((isPremiumMember && cartTotal >= 2000) ||
        (isPremiumMember && hasCoupon)) {
      return true;
    }
    return false;
  }
}
