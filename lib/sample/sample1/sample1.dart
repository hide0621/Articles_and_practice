/// sealed classを用いた書き方

// 1. タイプコードをクラスに変換する: 共通のインターフェースとなるsealed classを定義
sealed class EmployeeType {
  // 抽象メソッドとして定義し、各サブクラスでの実装を強制
  // 各サブクラスはこの実装により個々の振る舞いを表現することができる
  double calculateSalary();
}

// 2. sealed classを継承するサブクラス（役職ごとのクラス）を定義
// これらのサブクラスは、他のファイルからは継承できない
class Manager extends EmployeeType {
  double monthlySalary;
  Manager(this.monthlySalary);

  @override
  double calculateSalary() => monthlySalary;
}

class Engineer extends EmployeeType {
  double monthlySalary;
  Engineer(this.monthlySalary);

  @override
  double calculateSalary() => monthlySalary;
}

class PartTime extends EmployeeType {
  int hoursWorked;
  double hourlyRate;
  PartTime(this.hoursWorked, this.hourlyRate);

  @override
  double calculateSalary() => hoursWorked * hourlyRate;
}

class Employee {
  // 3. メソッドをクラスに移す: Employeeクラスが給与計算ロジックを持つ
  EmployeeType type;

  Employee(this.type);

  double getSalary() {
    return type.calculateSalary();
  }

  // switch文を用いた網羅性チェック
  // sealed classのおかげで、すべてのサブクラスをカバーしているかコンパイル時にチェックされる
  String getEmployeeDescription() {
    return switch (type) {
      Manager m => "管理職: 月給 ${m.monthlySalary}円",
      Engineer e => "エンジニア: 月給 ${e.monthlySalary}円",
      PartTime p => "パートタイム: 時給 ${p.hourlyRate}円 × ${p.hoursWorked}時間",
      // sealed classなので、すべてのケースを網羅していないとコンパイルエラーになる
    };
  }

  // 別の例: 昇給の可否を判定
  bool isEligibleForRaise() {
    return switch (type) {
      Manager() => true, // 管理職は昇給対象
      Engineer() => true, // エンジニアも昇給対象
      PartTime() => false, // パートタイムは昇給対象外
    };
  }
}

void main() {
  final manager = Employee(Manager(500000));
  final engineer = Employee(Engineer(400000));
  final partTimer = Employee(PartTime(160, 1500));

  print("Manager Salary: ${manager.getSalary()}");
  print("Engineer Salary: ${engineer.getSalary()}");
  print("Part-timer Salary: ${partTimer.getSalary()}");

  print("\n--- switch文による網羅性チェックのデモ ---");
  print(manager.getEmployeeDescription());
  print("昇給対象: ${manager.isEligibleForRaise()}");

  print(engineer.getEmployeeDescription());
  print("昇給対象: ${engineer.isEligibleForRaise()}");

  print(partTimer.getEmployeeDescription());
  print("昇給対象: ${partTimer.isEligibleForRaise()}");
}

// /// リファクタリング前

// enum EmployeeType {
//   manager,
//   engineer,
//   partTime,
// }

// class Employee {
//   EmployeeType type;
//   double monthlySalary;
//   int hoursWorked;
//   double hourlyRate;

//   Employee(this.type,
//       {this.monthlySalary = 0, this.hoursWorked = 0, this.hourlyRate = 0});
// }

// double calculateSalary(Employee employee) {
//   if (employee.type == EmployeeType.manager) {
//     // マネージャーの給与計算
//     return employee.monthlySalary;
//   } else if (employee.type == EmployeeType.engineer) {
//     // エンジニアの給与計算
//     return employee.monthlySalary;
//   } else if (employee.type == EmployeeType.partTime) {
//     // パートタイマーの給与計算
//     return employee.hoursWorked * employee.hourlyRate;
//   } else {
//     throw Exception("Invalid employee type");
//   }
// }

// void main() {
//   final manager = Employee(EmployeeType.manager, monthlySalary: 500000);
//   final engineer = Employee(EmployeeType.engineer, monthlySalary: 400000);
//   final partTimer =
//       Employee(EmployeeType.partTime, hoursWorked: 160, hourlyRate: 1500);

//   print("Manager Salary: ${calculateSalary(manager)}");
//   print("Engineer Salary: ${calculateSalary(engineer)}");
//   print("Part-timer Salary: ${calculateSalary(partTimer)}");
// }
