import 'package:flutter/material.dart' show ThemeMode;
import 'package:rekordi/domain/repository/file/interface/preferences.dart';
import 'package:rekordi/util/exception/fail_delete_exception.dart';
import 'package:rekordi/util/exception/fail_update_exception.dart';

/// アプリの環境設定をローカルファイルで管理するためのクラス
class PreferencesRepository {
  PreferencesRepository(this._instance);

  final IPreferences _instance;

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
