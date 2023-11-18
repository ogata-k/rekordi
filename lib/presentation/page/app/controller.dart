import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/presentation/event/theme/updated_theme_mode.dart';
import 'package:rekordi/presentation/page/app/model.dart';
import 'package:rekordi/presentation/page/controller.dart';
import 'package:rekordi/presentation/usecase/theme/get_theme_mode.dart';

class RekordiAppController extends IPageController<RekordiAppModel> {
  RekordiAppController(super.model, {required this.preferences}) {
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

  ThemeMode _getThemeMode() => GetThemeModeUsecase(preferences).call();
}
