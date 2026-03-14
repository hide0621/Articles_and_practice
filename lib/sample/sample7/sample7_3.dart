/// ネストしたfor文に対するリファクタリングのベストプラクティス例
/// what（何をするのか）とhow（どのようにするのか）を明確に分けつつ、高階関数を活用してfor文のネストを隠蔽する

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

// --- 隠蔽された制御構造（How） ---
/// 複雑なfor文のネストをカプセル化した関数。
/// 利用者はこの中身のループ構造を意識する必要はありません。
Future<void> _forEachEmployeeInCompanies(
  List<Company> companies,
  // 実行したい処理を無名関数（コールバック）として受け取る
  Future<void> Function(
          Company company, Department department, Employee employee)
      action,
) async {
  for (final company in companies) {
    for (final department in company.departments) {
      for (final employee in department.employees) {
        // 受け取った一番重要な処理をここで実行する
        await action(company, department, employee);
      }
    }
  }
}

// --- メインのビジネスロジック（What） ---
Future<void> sendMessagesToAllEmployees(
  List<Company> companies,
  MessageRepository repository,
) async {
  // ネストを隠蔽した関数を呼び出し、無名関数として「一番重要な処理」を渡す
  await _forEachEmployeeInCompanies(companies,
      (company, department, employee) async {
    // 【本質的な処理】メッセージの作成と保存が直感的に読み取れる！
    final message =
        '${company.name}の${department.name}に所属する${employee.name}さん、今月もお疲れ様でした！';
    await repository.saveMessage(employee, message);
  });
}
