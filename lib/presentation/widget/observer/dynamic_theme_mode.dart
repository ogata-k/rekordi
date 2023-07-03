import 'package:flutter/material.dart';
import 'package:rekordi/component/locator.dart';
import 'package:rekordi/domain/repository/preferences.dart';
import 'package:rekordi/presentation/usecase/preferences/get_theme_mode.dart';

/// アプリの[ThemeMode]を動的に変更する機構を提供するWidget
/// of staticメソッドでアクセスできる
class DynamicThemeMode extends StatefulWidget {
  const DynamicThemeMode({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, ThemeMode themeMode) builder;

  @override
  State<DynamicThemeMode> createState() => _DynamicThemeModeState();

  static AppThemeMode? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppThemeMode>();
}

class _DynamicThemeModeState extends State<DynamicThemeMode> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode =
        GetThemeModeUsecase(AppLocator().get<PreferencesRepository>()).call();
  }

  void setThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeMode._(
      key: widget.key,
      currentMode: _themeMode,
      setThemeMode: setThemeMode,
      child: widget.builder(context, _themeMode),
    );
  }
}

/// 静的なWidgetとして用意する。
/// 必要があれば引数の[child]にリビルドを要求する
class AppThemeMode extends InheritedWidget {
  const AppThemeMode._({
    Key? key,
    required this.currentMode,
    required this.setThemeMode,
    required Widget child,
  }) : super(key: key, child: child);

  final ThemeMode currentMode;
  final void Function(ThemeMode themeMode) setThemeMode;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is! AppThemeMode || oldWidget.currentMode != currentMode;
  }
}
