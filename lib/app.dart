import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/presentation/model/app_theme_mode.dart';
import 'package:rekordi/presentation/resource/l10n/l10n.dart';
import 'package:rekordi/presentation/resource/theme/theme.dart';
import 'package:rekordi/presentation/routing.dart';

/// アプリ本体
class RekordiApp extends StatelessWidget {
  const RekordiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = getRouter();

    return Consumer(
      builder: (context, ref, child) {
        final themeBuilder = AppThemeBuilder.appDefault();
        final ThemeMode appThemeMode = ref.watch(appThemeModeStateProvider);

        return MaterialApp.router(
          localizationsDelegates: AppL10n.localizationsDelegates,
          supportedLocales: AppL10n.supportedLocales,
          theme: themeBuilder.buildLight(),
          darkTheme: themeBuilder.buildDark(),
          themeMode: appThemeMode,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          routerConfig: router,
        );
      },
    );
  }
}
