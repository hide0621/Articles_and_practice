/// 生焼けオブジェクトの例

// class Configuration {
//   String databaseUrl;
//   String? apiKey; // APIキーはオプショナル（NUll許容型）とする

//   // プライベートコンストラクタで、外部からの直接生成を防ぐ
//   Configuration._internal(this.databaseUrl, {this.apiKey});

//   // ファクトリコンストラクタで生成ロジックを集中させる
//   factory Configuration.fromJson(Map<String, dynamic> json) {
//     // データベースURLは必須だが、JSON内に存在しない可能性がある
//     if (!json.containsKey('databaseUrl')) {
//       // 本来ならエラーをスローすべきだが、ここでは「不完全な状態」で続行するロジックを想定
//       print(
//           "Warning: databaseUrl is missing! Creating potentially incomplete object.");

//       // ここで仮の値（あるいはnullを許容する設計ミス）でインスタンスを生成してしまう
//       // この時点では apiKey も初期化されていない
//       return Configuration._internal("default_url");
//     }

//     // データベースURLは取得できたが、APIキーがない場合もある
//     final dbUrl = json['databaseUrl'] as String;
//     final key = json['apiKey'] as String?;

//     return Configuration._internal(dbUrl, apiKey: key);
//   }
// }

// void main() {
//   // 意図的に databaseUrl を含まない不正なJSONデータ
//   final Map<String, dynamic> invalidJson = {
//     'apiKey': 'secret123'
//     // 'databaseUrl' がない！
//   };

//   final config = Configuration.fromJson(invalidJson);

//   // 警告は出るが、実行は停止しない
//   print("Config URL: ${config.databaseUrl}"); // default_url が表示される
//   print("Config Key: ${config.apiKey}"); // secret123 が表示される

//   // この config オブジェクトは「生焼け」である。
//   // 本来期待される databaseUrl が設定されていないため、後続のDB接続処理などでエラーになる可能性がある。
// }

/// 解消法
///

class Configuration {
  final String databaseUrl; // finalと非Nullで堅牢に
  final String? apiKey;

  Configuration._internal(this.databaseUrl, {this.apiKey});

  factory Configuration.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('databaseUrl')) {
      // 必須情報がなければ、ArgumentError をスローしてオブジェクト生成を中止する
      throw ArgumentError("Missing required parameter: 'databaseUrl'");
    }

    final dbUrl = json['databaseUrl'] as String;
    final key = json['apiKey'] as String?;

    // エラーなくここまで来たら、完全なオブジェクトを生成できる
    return Configuration._internal(dbUrl, apiKey: key);
  }
}

void main() {
  final Map<String, dynamic> invalidJson = {'apiKey': 'secret123'};

  try {
    // 生成時にエラーがスローされるため、config変数は生成されない
    final config = Configuration.fromJson(invalidJson);
    print("Config URL: ${config.databaseUrl}");
  } catch (e) {
    // 例外をキャッチし、不正な状態のオブジェクトが使われることを防ぐ
    print("Failed to create configuration object: $e");
  }
}
// 出力: Failed to create configuration object: Invalid argument(s): Missing required parameter: 'databaseUrl'
