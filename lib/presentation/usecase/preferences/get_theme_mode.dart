import 'package:flutter/material.dart' show ThemeMode;
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';

/// アプリのテーマがダークテーマかライトテーマかを取得する。
/// どちらでもない場合はシステム依存を返す。
class GetThemeModeUsecase extends BaseUsecase {
  GetThemeModeUsecase(this.preferences);

  final PreferencesRepository preferences;

  ThemeMode call() => preferences.getThemeMode();
}
