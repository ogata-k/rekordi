import 'package:flutter/material.dart' show ThemeMode;
import 'package:rekordi/domain/component/event_bus.dart';
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/presentation/event/theme/updated_theme_mode.dart';
import 'package:rekordi/presentation/usecase/usecase.dart';
import 'package:rekordi/util/model/nothing.dart';
import 'package:rekordi/util/model/pair.dart';

/// アプリのテーマがダークテーマかライトテーマかを更新する。
class UpdateThemeModeAsyncUsecase extends IUsecase {
  UpdateThemeModeAsyncUsecase(this.preferences);

  final PreferencesRepository preferences;

  Future<WithCallback<Nothing, AppEventBus>> call(ThemeMode? themeMode) =>
      preferences.setThemeMode(themeMode).then(
        (_) {
          return Pair(Nothing.value(), (eventBus) {
            eventBus.fire(UpdatedThemeModeEvent());
          });
        },
      );
}
