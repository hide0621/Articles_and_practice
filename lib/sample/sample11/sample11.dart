class Repository {
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2)); 
    return "Fetched Data";
  }
}

// /// グローバルに参照可能なシングルトン
// final repository = Repository();

// class UseCase1 {
//   Future<String> execute() async {
//     return await repository.fetchData();
//   }
// }

// class UseCase2 {
//   Future<String> execute() async {
//     return await repository.fetchData();
//   }
// }

/// コンストラクタインジェクションを使用して依存関係を注入

class UseCase1 {
  final Repository repository;

  UseCase1(this.repository);

  Future<String> execute() async {
    return await repository.fetchData();
  }
}

class UseCase2 {
  final Repository repository;

  UseCase2(this.repository);

  Future<String> execute() async {
    return await repository.fetchData();
  }
}