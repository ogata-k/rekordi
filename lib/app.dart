import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/presentation/resource/l10n/l10n.dart';
import 'package:rekordi/presentation/resource/theme/theme.dart';
import 'package:rekordi/presentation/routing.dart';

/// アプリ本体
class RekordiApp extends StatelessWidget {
  const RekordiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = getRouter();
    final themeBuilder = AppThemeBuilder.appDefault();

    return MaterialApp.router(
      localizationsDelegates: AppL10n.localizationsDelegates,
      supportedLocales: AppL10n.supportedLocales,
      theme: themeBuilder.buildLight(),
      darkTheme: themeBuilder.buildDark(),
      // TODO 画面から切り替えられるようにする
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routerConfig: router,
    );
  }
}
