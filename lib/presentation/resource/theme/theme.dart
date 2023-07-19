import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Theme builder
class AppThemeBuilder {
  const AppThemeBuilder._(this._builder);

  factory AppThemeBuilder.fromColorScheme(
    ColorScheme Function(Brightness brightness) colorSchemeBuilder,
  ) =>
      AppThemeBuilder._((Brightness brightness) {
        final ColorScheme colorScheme = colorSchemeBuilder(brightness);
        final Typography typography = Typography.material2021(
          platform: defaultTargetPlatform,
          colorScheme: colorScheme,
        );
        final TextTheme textTheme = colorScheme.brightness == Brightness.light
            ? typography.black
            : typography.white;

        ThemeData theme = ThemeData.from(
          useMaterial3: true,
          colorScheme: colorScheme,
        ).copyWith(
          // Typographyも設定するために意図的に指定
          typography: typography,
          textTheme: textTheme,
        );

        theme = theme.copyWith(
          appBarTheme: theme.appBarTheme.copyWith(
            centerTitle: true,
            toolbarHeight: 52.0,
            backgroundColor: theme.useMaterial3
                ? colorScheme.inversePrimary
                : theme.appBarTheme.backgroundColor,
          ),
        );

        return theme.copyWith(
          // 拡張テーマのデフォルト値を指定する
          // 最後に指定してもろもろの設定が適用されたThemeDataを使うようにする
          extensions: AppTheme._generateBaseExtension(theme),
        );
      });

  factory AppThemeBuilder.fromSeed(Color seedColor) =>
      AppThemeBuilder.fromColorScheme(
        (Brightness brightness) => ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: seedColor,
        ),
      );

  /// アプリの[Theme]を構築するインスタンスを作成
  factory AppThemeBuilder.appDefault() =>
      AppThemeBuilder.fromSeed(const Color(0xFF80D8FF));

  /// core builder function
  final ThemeData Function(Brightness brightness) _builder;

  /// 指定したテーマモードで構築
  ThemeData build(Brightness brightness) => _builder(brightness);

  /// ライトテーマで構築
  ThemeData buildLight() => build(Brightness.light);

  /// ダークテーマで構築
  ThemeData buildDark() => build(Brightness.dark);
}

/// アプリテーマ
class AppTheme {
  factory AppTheme.of(BuildContext context) => AppTheme._(Theme.of(context));

  AppTheme._(this._theme);

  final ThemeData _theme;

  ThemeData get basic => _theme;

  /// ベースとなるThemeExtensionの一覧を生成
  static List<ThemeExtension<dynamic>> _generateBaseExtension(
    ThemeData theme,
  ) =>
      [
        // @todo このメソッドで指定されなかった物はこのクラス内で定義されたフォールバックを利用するようにする
      ];

  /// ThemeExtensionの一覧のコピー用ヘルパ
  ThemeData copyExtensionsWith() => _theme.copyWith(
        // @todo 引数のデータをもとにコピーするようにする
        extensions: _theme.extensions.values,
      );
}
