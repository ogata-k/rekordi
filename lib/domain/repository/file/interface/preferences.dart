/// アプリの環境設定をローカルファイルで管理するための抽象クラス
abstract interface class Preferences {
  /// [key]に保存してある[bool]値を取得
  bool? getBool(String key);

  /// [key]に保存してある[double]値を取得
  double? getDouble(String key);

  /// [key]に保存してある[int]値を取得
  int? getInt(String key);

  /// [key]に保存してある[String]値を取得
  String? getString(String key);

  /// [key]に保存してある[String]を値にもつ[List]値を取得
  List<String>? getStringList(String key);

  /// キャッシュを更新する
  Future<void> reload();

  /// [bool]値を指定した[key]に紐づけて保存する
  // ignore: avoid_positional_boolean_parameters
  Future<bool> setBool(String key, bool value);

  /// [double]値を指定した[key]に紐づけて保存する
  Future<bool> setDouble(String key, double value);

  /// [int]値を指定した[key]に紐づけて保存する
  Future<bool> setInt(String key, int value);

  /// [String]値を指定した[key]に紐づけて保存する
  Future<bool> setString(String key, String value);

  /// [String]を値にもつ[List]値を指定した[key]に紐づけて保存する
  Future<bool> setStringList(String key, List<String> value);

  /// [key]とその[key]に紐づく値を削除する
  Future<bool> remove(String key);

  /// 保存してある値をすべて削除
  Future<bool> clear();
}
