import 'package:flutter/widgets.dart';
import 'package:rekordi/domain/component/interface/router.dart' as cr;
import 'package:rekordi/domain/component/locator.dart';

/// 簡単に扱うためのヘルパ
AppRouter router() => locator().get<AppRouter>();

/// ルーティングで遷移するときに利用するパラメーター
/// [queryParameters]はJsonに変換できることを期待している
class RouteSetting {
  RouteSetting({
    required this.path,
    this.queryParameters = const <String, dynamic>{},
  });

  final String path;
  final Map<String, dynamic /*String?|Iterable<String>*/ > queryParameters;

  /// hoge/fuga?query=1&param=2の形式に変換する
  String toLocation() {
    return Uri(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    ).toString();
  }
}

/// アプリのルーティングを担うルーター
class AppRouter {
  const AppRouter(this._instance);

  final cr.IRouter _instance;

  /// 指定された[setting]を解析して得られたパスをもとに遷移する。
  Future<T?> push<T extends Object?>(
    BuildContext context,
    RouteSetting setting,
  ) =>
      _instance.push(
        context,
        setting.toLocation(),
      );

  /// 指定された[setting]を解析して得られたパスをもとに遷移する。
  /// 画面のスタックを全部削除して遷移する。
  void go(
    BuildContext context,
    RouteSetting setting,
  ) =>
      _instance.go(
        context,
        setting.toLocation(),
      );

  /// 指定された[setting]を解析して得られたパスをもとに遷移する。
  /// 遷移元を置き換えながら遷移する。
  Future<T?> pushReplacement<T extends Object?>(
    BuildContext context,
    RouteSetting setting,
  ) =>
      _instance.pushReplacement(
        context,
        setting.toLocation(),
      );

  /// 画面が取り除くことができるならtrue
  bool canPop(BuildContext context) => _instance.canPop(context);

  /// 画面を取り除く
  void pop<T extends Object>(BuildContext context, [T? result]) =>
      _instance.pop(context, result);

  /// 画面一番上のダイアログを取り除く
  void closeDialog<T extends Object>(BuildContext context, [T? result]) =>
      _instance.closeDialog(context, result);
}
