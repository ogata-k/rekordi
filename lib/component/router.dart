import 'package:flutter/widgets.dart';
import 'package:rekordi/infra/component/router.dart';
import 'package:rekordi/presentation/page/base.dart';

/// アプリのルーティングを担うルーター
class AppRouter {
  const AppRouter._(this._context);

  // 実際のofメソッドの挙動とは違うが、ほかのルーターと同様に使えるようにこの名前で宣言
  factory AppRouter.of(BuildContext context) => AppRouter._(context);

  static final Router _instance = ComponentGoRouter();

  final BuildContext _context;

  Future<T?> push<Extra extends BasePageExtra, T extends Object?>(
    Extra extra,
  ) =>
      _instance.push(_context, extra.absolutePagePath, extra);

  Future<T?> pushWithReplace<Extra extends BasePageExtra, T extends Object?>(
    Extra extra,
  ) =>
      _instance.pushWithReplace(_context, extra.absolutePagePath, extra);

  // @todo go_router v9.0.0が未対応なので対応していない
  Future<T?> pushWithClearStack<Extra extends BasePageExtra, T extends Object?>(
    Extra extra,
  ) =>
      _instance.pushWithClearStack(_context, extra.absolutePagePath, extra);

  bool canPop() => _instance.canPop(_context);

  void pop<T extends Object>([T? result]) => _instance.pop(_context, result);

  // @todo go_router v9.0.0が未対応なので対応していない
  void popUntilThePath(List<String> path) =>
      _instance.popUntilThePath(_context, path);

  // @todo go_router v9.0.0が未対応なので対応していない
  void popUntilTheName(List<String> name) =>
      _instance.popUntilTheName(_context, name);

  // @todo go_router v9.0.0が未対応なので対応していない
  void popUntilNotFirst() => _instance.popUntilNotFirst(_context);

  void closeDialog<T extends Object>([T? result]) =>
      _instance.closeDialog(_context, result);
}

abstract class Router {
  Future<T?> push<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  );

  Future<T?> pushWithReplace<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  );

  Future<T?> pushWithClearStack<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  );

  bool canPop(BuildContext context);

  void pop<T extends Object>(BuildContext context, [T? result]);

  void popUntilThePath(BuildContext context, List<String> path);

  void popUntilTheName(BuildContext context, List<String> name);

  void popUntilNotFirst(BuildContext context);

  void closeDialog<T extends Object>(BuildContext context, [T? result]);
}
