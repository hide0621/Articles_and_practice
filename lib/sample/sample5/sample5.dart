// /// デメテルの法則に反したメソッドチェイン

// void equipArmor(int menberId, Equipment newArmor) {
//   if (party.members.get(menberId).equipments.canChange) {
//     party.members.get(menberId).equipments.armor = newArmor;
//   }
// }

/// デメテルの法則に従った設計例

enum Equipment {
  EMPTY,
  HELMET,
  ARMOR,
  ARM_GUARD,
}

class Equipments {
  Equipments({
    required bool canChange,
    required Equipment head,
    required Equipment armor,
    required Equipment arm,
  })  : _canChange = canChange,
        _head = head,
        _armor = armor,
        _arm = arm;

  bool _canChange;
  Equipment _head;
  Equipment _armor;
  Equipment _arm;

  void equipArmor(Equipment newArmor) {
    if (_canChange) {
      _armor = newArmor;
    }
  }

  void deactivateAll() {
    _head = Equipment.EMPTY;
    _armor = Equipment.EMPTY;
    _arm = Equipment.EMPTY;
  }
}
