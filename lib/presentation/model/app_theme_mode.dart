/* TODO replace to Usecase and Controller and EventBus
final StateNotifierProvider<AppThemeMode, ThemeMode> appThemeModeStateProvider =
    StateNotifierProvider((ref) {
  final ThemeMode initial =
      GetThemeModeUsecase(locator().get<PreferencesRepository>()).call();
  return AppThemeMode(initial);
});

/// このアプリの[ThemeMode]を伝えるためのクラス
class AppThemeMode extends StateNotifier<ThemeMode> {
  AppThemeMode(ThemeMode themeMode) : super(themeMode);

  ThemeMode get currentMode => state;

  /// [ThemeMode]を設定する
  void setThemeMode(ThemeMode? themeMode) {
    UpdateThemeModeUsecase(
      locator().get<PreferencesRepository>(),
    ).call(themeMode).then((_) {
      final ThemeMode currentStoredThemeMode = GetThemeModeUsecase(
        locator().get<PreferencesRepository>(),
      ).call();
      state = currentStoredThemeMode;
    });
  }
}
*/
