import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rekordi/component/locator.dart';
import 'package:rekordi/domain/repository/preferences.dart';
import 'package:rekordi/presentation/usecase/preferences/get_theme_mode.dart';
import 'package:rekordi/presentation/usecase/preferences/update_theme_mode.dart';

final StateNotifierProvider<AppThemeMode, ThemeMode> appThemeModeStateProvider =
    StateNotifierProvider((ref) {
  final ThemeMode initial =
      GetThemeModeUsecase(AppLocator().get<PreferencesRepository>()).call();
  return AppThemeMode(initial);
});

/// このアプリの[ThemeMode]を伝えるためのクラス
class AppThemeMode extends StateNotifier<ThemeMode> {
  AppThemeMode(ThemeMode themeMode) : super(themeMode);

  ThemeMode get currentMode => state;

  void setThemeMode(ThemeMode? themeMode) {
    UpdateThemeModeUsecase(
      AppLocator().get<PreferencesRepository>(),
    ).call(themeMode).then((_) {
      final ThemeMode currentStoredThemeMode = GetThemeModeUsecase(
        AppLocator().get<PreferencesRepository>(),
      ).call();
      state = currentStoredThemeMode;
    });
  }
}
