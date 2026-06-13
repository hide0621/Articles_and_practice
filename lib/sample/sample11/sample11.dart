class Repository {
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2)); 
    return "Fetched Data";
  }
}

/// グローバルに参照可能なシングルトン
final repository = Repository();

class UseCase1 {
  Future<String> execute() async {
    return await repository.fetchData();
  }
}

class UseCase2 {
  Future<String> execute() async {
    return await repository.fetchData();
  }
}