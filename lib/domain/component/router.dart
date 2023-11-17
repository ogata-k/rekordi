import 'package:flutter/widgets.dart';
import 'package:rekordi/domain/component/interface/router.dart' as cr;
import 'package:rekordi/domain/component/locator.dart';
import 'package:rekordi/presentation/page/view.dart';

/// 簡単に扱うためのヘルパ
AppRouter router() => locator().get<AppRouter>();

/// アプリのルーティングを担うルーター
class AppRouter {
  const AppRouter(this._instance);

  final cr.IRouter _instance;

  /// 指定された[extra]を解析して得られたパスをもとに遷移する。
  Future<T?> push<Extra extends IPageExtra, T extends Object?>(
    BuildContext context,
    Extra extra,
  ) =>
      _instance.push(context, extra.absolutePagePath, extra);

  /// 指定された[extra]を解析して得られたパスをもとに遷移する。
  /// 画面のスタックを全部削除して遷移する。
  void go<Extra extends IPageExtra>(
    BuildContext context,
    Extra extra,
  ) =>
      _instance.go(context, extra.absolutePagePath, extra);

  /// 指定された[extra]を解析して得られたパスをもとに遷移する。
  /// 遷移元を置き換えながら遷移する。
  Future<T?> pushReplacement<Extra extends IPageExtra, T extends Object?>(
    BuildContext context,
    Extra extra,
  ) =>
      _instance.pushReplacement(context, extra.absolutePagePath, extra);

  /// 画面が取り除くことができるならtrue
  bool canPop(BuildContext context) => _instance.canPop(context);

  /// 画面を取り除く
  void pop<T extends Object>(BuildContext context, [T? result]) =>
      _instance.pop(context, result);

  /// 画面一番上のダイアログを取り除く
  void closeDialog<T extends Object>(BuildContext context, [T? result]) =>
      _instance.closeDialog(context, result);
}
