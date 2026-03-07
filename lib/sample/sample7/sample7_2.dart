/// ネストしたforb文に対するリファクタリングのアンチパターン例

// --- データモデルの定義 ---
class Employee {
  final String name;
  Employee(this.name);
}

class Department {
  final String name;
  final List<Employee> employees;
  Department(this.name, this.employees);
}

class Company {
  final String name;
  final List<Department> departments;
  Company(this.name, this.departments);
}

// --- Repository層の定義 ---
class MessageRepository {
  /// データベースやAPI通信などでメッセージを保存する想定のメソッド
  Future<void> saveMessage(Employee employee, String message) async {
    // 実際のアプリではここでDB保存処理などを実装します
    print('【保存完了】 送信先: ${employee.name} | 内容: $message');
  }
}

Future<void> sendMessagesToAllEmployees(
  List<Company> companies,
  MessageRepository repository,
) async {
  // 1階層目: 会社ごとの処理を呼び出す
  await _processCompanies(companies, repository);
}

// 会社リストを回すだけのメソッド
Future<void> _processCompanies(
  List<Company> companies,
  MessageRepository repository,
) async {
  for (final company in companies) {
    // 内部で次の階層のメソッドをcall
    await _processDepartments(company, repository);
  }
}

// 部署リストを回すだけのメソッド
Future<void> _processDepartments(
  Company company,
  MessageRepository repository,
) async {
  for (final department in company.departments) {
    // 内部でさらに次の階層のメソッドをcall
    await _processEmployees(company, department, repository);
  }
}

// 従業員リストを回して保存処理をするメソッド
Future<void> _processEmployees(
  Company company,
  Department department,
  MessageRepository repository,
) async {
  for (final employee in department.employees) {
    final message =
        '${company.name}の${department.name}に所属する${employee.name}さん、今月もお疲れ様でした！';

    // 一番深い処理
    await repository.saveMessage(employee, message);
  }
}
