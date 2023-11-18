import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/presentation/event/theme/updated_theme_mode.dart';
import 'package:rekordi/presentation/page/controller.dart';
import 'package:rekordi/presentation/page/home/model.dart';
import 'package:rekordi/presentation/usecase/theme/get_theme_mode.dart';
import 'package:rekordi/presentation/usecase/theme/update_theme_mode_async.dart';

class HomePageController extends IPageController<HomePageModel> {
  HomePageController(super.model, {required this.preferences}) {
    _updatedThemeModeListener = eventBus.listen<UpdatedThemeModeEvent>((event) {
      state = state.copyWith(
        themeMode: _getThemeMode(),
      );
    });
  }

  final PreferencesRepository preferences;
  StreamSubscription<UpdatedThemeModeEvent>? _updatedThemeModeListener;

  @override
  void dispose() {
    _updatedThemeModeListener?.cancel();
    _updatedThemeModeListener = null;
    super.dispose();
  }

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  ThemeMode _getThemeMode() => GetThemeModeUsecase(preferences).call();

  Future<void> updateThemeMode(ThemeMode? themeMode) async {
    await UpdateThemeModeAsyncUsecase(preferences)
        .call(themeMode)
        .then((value) {
      value.item2(eventBus);
    });
  }
}
