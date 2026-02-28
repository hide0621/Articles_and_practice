// A*B + A*C の状態を表すコード

// class Order {
//   bool isPremiumMember;
//   int cartTotal;
//   bool hasCoupon;

//   Order(this.isPremiumMember, this.cartTotal, this.hasCoupon);

//   bool isFreeShipping() {
//     // A*B + A*C の状態
//     if ((isPremiumMember && cartTotal >= 2000) ||
//         (isPremiumMember && hasCoupon)) {
//       return true;
//     }
//     return false;
//   }
// }

// リファクタリング前のコード
// A*B + A*C を整理して、A * (B + C) の状態を表すコード

class Order {
  bool isPremiumMember;
  int cartTotal;
  bool hasCoupon;

  Order(this.isPremiumMember, this.cartTotal, this.hasCoupon);

  bool isFreeShipping() {
    // 算術演算の論理で整理: A * (B + C)
    return isPremiumMember && (cartTotal >= 2000 || hasCoupon);
  }
}

// リファクタリング後のコード
// A*B + A*C を整理して、A * (B + C) の状態を表すコード

// class Order {
//   bool isPremiumMember;
//   int cartTotal;
//   bool hasCoupon;

//   Order(this.isPremiumMember, this.cartTotal, this.hasCoupon);

//   bool isFreeShipping() {
//     // 算術演算の論理で整理: A * (B + C)
//     // 整理されたことで「isEligibleForDiscount」という関数の抽出が明確に！
//     return isPremiumMember && _isEligibleForDiscount();
//   }

//   // 抽出した関数
//   bool _isEligibleForDiscount() {
//     return cartTotal >= 2000 || hasCoupon;
//   }
// }
