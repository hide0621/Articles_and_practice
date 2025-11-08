// 継承を用いるパターン

// abstract interface class Bird {
//   bool canFly();
//   bool hasBeak();
// }

// class CommonBird implements Bird {
//   @override
//   bool canFly() => true;

//   @override
//   bool hasBeak() => true;
// }

// class Penguin extends CommonBird {
//   @override
//   bool canFly() => false;
// }

// 合成を用いるパターン

abstract interface class Bird {
  bool hasBeak();
  bool canFly();
}

class CommonBird implements Bird {
  CommonBird();

  @override
  bool hasBeak() => true;

  @override
  bool canFly() => true;
}

// パターン1: デフォルト値を使用（最もシンプル）
class Penguin implements Bird {
  Penguin();

  final CommonBird _commonBird = CommonBird();

  @override
  bool hasBeak() => _commonBird.hasBeak();

  @override
  bool canFly() => false;
}

// パターン2: 依存性の注入（テスタビリティが高い）
// class Penguin implements Bird {
//   Penguin({CommonBird? commonBird}) : _commonBird = commonBird ?? CommonBird();

//   final CommonBird _commonBird;

//   @override
//   bool hasBeak() => _commonBird.hasBeak();

//   @override
//   bool canFly() => false;
// }

// パターン3: late初期化（遅延初期化が必要な場合）
// class Penguin implements Bird {
//   late final CommonBird _commonBird = CommonBird();

//   @override
//   bool hasBeak() => _commonBird.hasBeak();

//   @override
//   bool canFly() => false;
// }
