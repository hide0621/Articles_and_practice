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

// --- メインのビジネスロジック ---
Future<void> sendMessagesToAllEmployees(
  List<Company> companies,
  MessageRepository repository,
) async {
  // 1階層目: 会社リストから会社要素を取り出す
  for (final company in companies) {
    // 2階層目: 会社の部署リストから部署要素を取り出す
    for (final department in company.departments) {
      // 3階層目(一番深いループ): 部署の従業員リストから従業員(最終要素)を取り出す
      for (final employee in department.employees) {
        // 取り出した要素を組み合わせて保存するメッセージを作成
        final message =
            '${company.name}の${department.name}に所属する${employee.name}さん、今月もお疲れ様でした！';

        // 一番深いところでRepository層のメソッドを叩く
        // 最終要素である employee を引数として渡している
        await repository.saveMessage(employee, message);
      }
    }
  }
}

// --- 動作確認用のメイン関数 ---
void main() async {
  // ダミーデータの作成
  final companies = [
    Company('A株式会社', [
      Department('営業部', [Employee('佐藤'), Employee('鈴木')]),
      Department('開発部', [Employee('高橋')]),
    ]),
    Company('B株式会社', [
      Department('総務部', [Employee('田中'), Employee('伊藤')]),
    ]),
  ];

  final repository = MessageRepository();

  print('--- 処理開始 ---');
  await sendMessagesToAllEmployees(companies, repository);
  print('--- 処理終了 ---');
}
