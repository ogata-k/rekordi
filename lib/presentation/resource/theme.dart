import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Theme builder
class ThemeBuilder {
  const ThemeBuilder._(this._builder);

  factory ThemeBuilder.fromColorScheme(
    ColorScheme Function(Brightness brightness) colorSchemeBuilder,
  ) =>
      ThemeBuilder._((Brightness brightness) {
        final ColorScheme colorScheme = colorSchemeBuilder(brightness);
        final Typography typography = Typography.material2021(
          platform: defaultTargetPlatform,
          colorScheme: colorScheme,
        );
        final TextTheme textTheme = colorScheme.brightness == Brightness.light
            ? typography.black
            : typography.white;
        final ThemeData theme = ThemeData.from(
          useMaterial3: true,
          colorScheme: colorScheme,
        ).copyWith(
          // Typographyも設定するために意図的に指定
          typography: typography,
          textTheme: textTheme,
        );

        return theme.copyWith(
          appBarTheme: theme.appBarTheme.copyWith(
            centerTitle: true,
            toolbarHeight: 52.0,
            backgroundColor: theme.useMaterial3
                ? colorScheme.inversePrimary
                : theme.appBarTheme.backgroundColor,
          ),
        );
      });

  factory ThemeBuilder.fromSeed(Color seedColor) =>
      ThemeBuilder.fromColorScheme(
        (Brightness brightness) => ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: seedColor,
        ),
      );

  /// アプリの[Theme]を構築するインスタンスを作成
  factory ThemeBuilder.appDefault() =>
      ThemeBuilder.fromSeed(const Color(0xFF80D8FF));

  /// core builder function
  final ThemeData Function(Brightness brightness) _builder;

  /// 指定したテーマモードで構築
  ThemeData build(Brightness brightness) => _builder(brightness);

  /// ライトテーマで構築
  ThemeData buildLight() => build(Brightness.light);

  /// ダークテーマで構築
  ThemeData buildDark() => build(Brightness.dark);
}
