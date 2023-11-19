import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/domain/component/locator.dart';
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/presentation/page/app/controller.dart';
import 'package:rekordi/presentation/page/app/model.dart';
import 'package:rekordi/presentation/page/view.dart';
import 'package:rekordi/presentation/resource/l10n/l10n.dart';
import 'package:rekordi/presentation/resource/theme/theme.dart';
import 'package:rekordi/presentation/routing.dart';
import 'package:rekordi/presentation/usecase/theme/get_theme_mode.dart';

/// アプリ本体
class RekordiApp extends IPage<RekordiAppModel, RekordiAppController> {
  const RekordiApp({super.key});

  @override
  RekordiAppController createController(BuildContext context) {
    final PreferencesRepository preferences =
        locator().get<PreferencesRepository>();
    final RekordiAppModel model =
        RekordiAppModel(themeMode: GetThemeModeUsecase(preferences).call());

    return RekordiAppController(
      model,
      preferences: preferences,
    );
  }

  @override
  Widget buildPage(BuildContext context, Widget? child) {
    final GoRouter router = getRouter();
    final themeBuilder = AppThemeBuilder.appDefault();

    return Consumer<RekordiAppModel>(
      builder: (BuildContext context, RekordiAppModel value, Widget? child) {
        return MaterialApp.router(
          localizationsDelegates: AppL10n.localizationsDelegates,
          supportedLocales: AppL10n.supportedLocales,
          theme: themeBuilder.buildLight(),
          darkTheme: themeBuilder.buildDark(),
          themeMode: value.themeMode,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          routerConfig: router,
        );
      },
    );
  }
}
