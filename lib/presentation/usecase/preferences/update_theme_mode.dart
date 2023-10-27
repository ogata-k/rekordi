import 'package:flutter/material.dart' show ThemeMode;
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';

/// アプリのテーマがダークテーマかライトテーマかを更新する。
class UpdateThemeModeUsecase extends BaseUsecase {
  UpdateThemeModeUsecase(this.preferences);

  final PreferencesRepository preferences;

  Future<void> call(ThemeMode? themeMode) =>
      preferences.setThemeMode(themeMode);
}
