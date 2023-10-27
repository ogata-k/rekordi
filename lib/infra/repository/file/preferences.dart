import 'package:rekordi/domain/repository/file/interface/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart' as plugin;

/// アプリの環境設定をローカルファイルで管理するためのクラス
class SharedPreferences implements IPreferences {
  SharedPreferences(this._instance);

  final plugin.SharedPreferences _instance;

  /// 自身のインスタンスを返却する
  static Future<SharedPreferences> buildInstance() async {
    final plugin.SharedPreferences prefInstance =
        await plugin.SharedPreferences.getInstance();
    // キャッシュを更新させる
    await prefInstance.reload();

    return SharedPreferences(prefInstance);
  }

  @override
  bool? getBool(String key) => _instance.getBool(key);

  @override
  double? getDouble(String key) => _instance.getDouble(key);

  @override
  int? getInt(String key) => _instance.getInt(key);

  @override
  String? getString(String key) => _instance.getString(key);

  @override
  List<String>? getStringList(String key) => _instance.getStringList(key);

  @override
  Future<void> reload() => _instance.reload();

  @override
  Future<bool> setBool(String key, bool value) => _instance.setBool(key, value);

  @override
  Future<bool> setDouble(String key, double value) =>
      _instance.setDouble(key, value);

  @override
  Future<bool> setInt(String key, int value) => _instance.setInt(key, value);

  @override
  Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);

  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _instance.setStringList(key, value);

  @override
  Future<bool> remove(String key) => _instance.remove(key);

  @override
  Future<bool> clear() => _instance.clear();
}
