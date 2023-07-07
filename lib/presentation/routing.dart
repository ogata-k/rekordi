import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/component/router.dart' as component;
import 'package:rekordi/presentation/page/error/error.dart';
import 'package:rekordi/presentation/page/home/home.dart';

/// AppRouterで扱える形式に変換するための具象クラス
class ComponentGoRouter extends component.Router {
  ComponentGoRouter();

  @override
  Future<T?> push<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  ) =>
      GoRouter.of(context).push<T>(path, extra: extra);

  @override
  Future<T?> pushWithReplace<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  ) =>
      GoRouter.of(context).pushReplacement(path, extra: extra);

  @override
  Future<T?> pushWithClearStack<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  ) {
    // @todo Not Support
    throw UnimplementedError('Not Support go_router: 9.0.0');
  }

  @override
  bool canPop(BuildContext context) => GoRouter.of(context).canPop();

  @override
  void pop<T extends Object>(BuildContext context, [T? result]) =>
      GoRouter.of(context).pop(result);

  @override
  void popUntilThePath(BuildContext context, List<String> path) {
    // @todo Not Support
    throw UnimplementedError('Not Support go_router: 9.0.0');
  }

  @override
  void popUntilTheName(BuildContext context, List<String> name) {
    // @todo Not Support
    throw UnimplementedError('Not Support go_router: 9.0.0');
  }

  @override
  void popUntilNotFirst(BuildContext context) {
    // @todo Not Support
    throw UnimplementedError('Not Support go_router: 9.0.0');
  }

  @override
  void closeDialog<T extends Object>(BuildContext context, [T? result]) =>
      Navigator.of(context).pop(result);
}

/// ルーティング情報を取得
GoRouter getRouter() {
  return GoRouter(
    // 初期値
    initialLocation: HomePageExtra.routingPath,
    initialExtra: HomePageExtra.defaultExtra(),

    // ルーティング一覧
    routes: <RouteBase>[
      GoRoute(
        path: ErrorPageExtra.routingPath,
        pageBuilder: (context, state) => _BasicRoutePage<void>(
          key: state.pageKey,
          child: ErrorPage(extra: state.extra! as ErrorPageExtra),
          transitionsBuilder: _fromBottom,
        ),
      ),
      GoRoute(
        path: HomePageExtra.routingPath,
        pageBuilder: (context, state) => _BasicRoutePage<void>(
          key: state.pageKey,
          child: HomePage(
            extra: state.extra! as HomePageExtra,
          ),
          transitionsBuilder: _fromRight,
        ),
      ),
    ],

    // ルーティングに失敗した場合の画面
    errorPageBuilder: (context, state) => _BasicRoutePage<void>(
      key: state.pageKey,
      // Extraを引数に与えて遷移してきているわけではないが、
      // エラー情報は保持しているので構築できる
      child: ErrorPage(extra: ErrorPageExtra(error: state.error)),
      // デフォルトより少し遅らせて表示させる
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: _fadeInPopToBottom,
    ),
  );
}

/// デフォルト設定を設定したこのアプリ用のルーティング
class _BasicRoutePage<T> extends CustomTransitionPage<T> {
  const _BasicRoutePage({
    required super.child,
    required super.transitionsBuilder,

    /// Duration to 400ms
    super.transitionDuration = const Duration(milliseconds: 400),

    /// Duration to 400ms
    super.reverseTransitionDuration = const Duration(milliseconds: 500),
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.opaque = true,
    super.barrierDismissible = false,
    super.barrierColor,
    super.barrierLabel,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });
}

/// フェードインアニメーション
Widget _noAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return child;
}

/// フェードインアニメーション
Widget _fadeIn(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

/// 右から左へのスライドアニメーション
Widget _fromRight(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: animation.drive(
      Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(
        CurveTween(curve: Curves.linear),
      ),
    ),
    child: child,
  );
}

/// 下から上へのスライドアニメーション
Widget _fromBottom(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: animation.drive(
      Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).chain(
        CurveTween(curve: Curves.linear),
      ),
    ),
    child: child,
  );
}

/// フェードインで入って、popするときには上から下にスライドしてアニメーション
Widget _fadeInPopToBottom(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  switch (animation.status) {
    case AnimationStatus.forward:
      return _fadeIn(context, animation, secondaryAnimation, child);
    case AnimationStatus.reverse:
      return _fromBottom(context, animation, secondaryAnimation, child);
    case AnimationStatus.dismissed:
    case AnimationStatus.completed:
      return child;
  }
}
