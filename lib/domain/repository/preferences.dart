import 'package:flutter/material.dart' show ThemeMode;
import 'package:rekordi/domain/domain_exception/repository_exception.dart';

/// アプリの環境設定をローカルファイルで管理するための抽象クラス
abstract class Preferences {
  bool? getBool(String key);

  double? getDouble(String key);

  int? getInt(String key);

  String? getString(String key);

  List<String>? getStringList(String key);

  Future<void> reload();

  // ignore: avoid_positional_boolean_parameters
  Future<bool> setBool(String key, bool value);

  Future<bool> setDouble(String key, double value);

  Future<bool> setInt(String key, int value);

  Future<bool> setString(String key, String value);

  Future<bool> setStringList(String key, List<String> value);

  Future<bool> remove(String key);

  Future<bool> clear();
}

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
