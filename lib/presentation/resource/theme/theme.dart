import 'package:flutter/material.dart';
import 'package:rekordi/presentation/resource/theme/const/color.dart';

typedef ExtensionsBuilder = List<ThemeExtension<dynamic>> Function(
  ThemeData theme,
  Brightness brightness,
);

/// Theme builder
class AppThemeBuilder {
  const AppThemeBuilder._(this._builder);

  factory AppThemeBuilder.fromColorScheme(
    ColorScheme Function(Brightness brightness) colorSchemeBuilder,
    ExtensionsBuilder buildExtensions,
  ) =>
      AppThemeBuilder._((Brightness brightness) {
        final ColorScheme colorScheme = colorSchemeBuilder(brightness);
        final ThemeData theme = ThemeData.from(
          useMaterial3: true,
          colorScheme: colorScheme,
        );

        return theme.copyWith(
          appBarTheme: theme.appBarTheme.copyWith(
            toolbarHeight: 48.0,
          ),
          // 拡張テーマのデフォルト値を指定する
          // 最後に指定してもろもろの設定が適用されたThemeDataを使うようにする
          extensions: buildExtensions(theme, brightness),
        );
      });

  /// アプリの[Theme]を構築するインスタンスを作成
  factory AppThemeBuilder.appDefault() => AppThemeBuilder.fromColorScheme(
        (Brightness brightness) => brightness == Brightness.light
            ? ColorConst.lightColorScheme
            : ColorConst.darkColorScheme,
        (ThemeData theme, Brightness brightness) => <ThemeExtension<dynamic>>[],
      );

  /// core builder function
  final ThemeData Function(Brightness brightness) _builder;

  /// 指定したテーマモードで構築
  ThemeData build(Brightness brightness) => _builder(brightness);

  /// ライトテーマで構築
  ThemeData buildLight() => build(Brightness.light);

  /// ダークテーマで構築
  ThemeData buildDark() => build(Brightness.dark);
}

class AppTheme {
  factory AppTheme.of(BuildContext context) => AppTheme._(Theme.of(context));

  AppTheme._(this._theme);

  final ThemeData _theme;

  ThemeData get data => _theme;

  T extension<T extends ThemeExtension<T>>() => _theme.extension<T>()!;

  T? extensionOrNull<T extends ThemeExtension<T>>() => _theme.extension<T>();

  T extensionOr<T extends ThemeExtension<T>>(T fallback) =>
      _theme.extension<T>() ?? fallback;

  T extensionOrElse<T extends ThemeExtension<T>>(T Function() fallbackFn) =>
      _theme.extension<T>() ?? fallbackFn();

  /// ThemeExtensionの一覧のコピー用ヘルパ
  ThemeData overrideExtension<T extends ThemeExtension<T>>(T extension) {
    final extensions = {..._theme.extensions};
    extensions[T] = extension;
    return _theme.copyWith(extensions: extensions.values);
  }
}
