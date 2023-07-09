import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/presentation/data_model/app_theme_mode.dart';
import 'package:rekordi/presentation/resource/theme.dart';
import 'package:rekordi/presentation/routing.dart';

/// アプリ本体
class RekordiApp extends StatelessWidget {
  const RekordiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = getRouter();

    return Consumer(
      builder: (context, ref, child) {
        final ThemeBuilder themeBuilder = ThemeBuilder.appDefault();
        final ThemeMode appThemeMode = ref.watch(appThemeModeStateProvider);

        return MaterialApp.router(
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
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
