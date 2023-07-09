import 'package:flutter/material.dart' show ThemeMode;
import 'package:rekordi/domain/domain_exception/repository_exception.dart';

/// アプリの環境設定をローカルファイルで管理するためのクラス
class PreferencesRepository {
  PreferencesRepository(this._instance);

  final Preferences _instance;

  static const String _appThemeMode = 'app_theme_mode';

  /// アプリテーマがダークモードかどうかを切り替えるフラグを取得
  ThemeMode getThemeMode() {
    switch (_instance.getString(_appThemeMode)) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        // デフォルトや不明値はシステムの設定値
        return ThemeMode.system;
    }
  }

  /// アプリテーマがダークモードかどうかを切り替えるフラグを保存
  Future<void> setThemeMode(ThemeMode? themeMode) async {
    if (themeMode == null) {
      final bool result = await _instance.remove(_appThemeMode);
      if (!result) {
        throw const FailDeleteException(
          'Value of Preferences\'s $_appThemeMode',
        );
      }
      return;
    }

    String? setting;
    switch (themeMode) {
      case ThemeMode.light:
        setting = 'light';
      case ThemeMode.dark:
        setting = 'dark';
      case ThemeMode.system:
        setting = 'system';
    }

    final bool result = await _instance.setString(_appThemeMode, setting);
    if (!result) {
      throw const FailUpdateException(
        'Value of Preferences\'s $_appThemeMode',
      );
    }
    return;
  }
}

/// アプリの環境設定をローカルファイルで管理するための抽象クラス
abstract class Preferences {
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
