/// リファクタリング後

// 1. タイプコードをクラスに変換する: 共通のインターフェースを定義
abstract interface class EmployeeType {
  double calculateSalary();
}

// 役職ごとのクラス
class Manager implements EmployeeType {
  double monthlySalary;
  Manager(this.monthlySalary);

  @override
  double calculateSalary() => monthlySalary;
}

class Engineer implements EmployeeType {
  double monthlySalary;
  Engineer(this.monthlySalary);

  @override
  double calculateSalary() => monthlySalary;
}

class PartTime implements EmployeeType {
  int hoursWorked;
  double hourlyRate;
  PartTime(this.hoursWorked, this.hourlyRate);

  @override
  double calculateSalary() => hoursWorked * hourlyRate;
}

class Employee {
  // 2. メソッドをクラスに移す: Employeeクラスが給与計算ロジックを持つ
  EmployeeType type;

  Employee(this.type);

  double getSalary() {
    return type.calculateSalary();
  }
}

void main() {
  final manager = Employee(Manager(500000));
  final engineer = Employee(Engineer(400000));
  final partTimer = Employee(PartTime(160, 1500));

  print("Manager Salary: ${manager.getSalary()}");
  print("Engineer Salary: ${engineer.getSalary()}");
  print("Part-timer Salary: ${partTimer.getSalary()}");
}
