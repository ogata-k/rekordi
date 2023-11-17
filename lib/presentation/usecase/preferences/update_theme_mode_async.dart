import 'package:flutter/material.dart' show ThemeMode;
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/presentation/usecase/usecase.dart';

/// アプリのテーマがダークテーマかライトテーマかを更新する。
class UpdateThemeModeAsyncUsecase extends IUsecase {
  UpdateThemeModeAsyncUsecase(this.preferences);

  final PreferencesRepository preferences;

  Future<void> call(ThemeMode? themeMode) =>
      preferences.setThemeMode(themeMode);
}
