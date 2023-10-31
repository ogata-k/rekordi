import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/presentation/page/error/error.dart';
import 'package:rekordi/presentation/page/home/home_page/home.dart';

/// エラーページを構築
Page<dynamic> _buildErrorPage(
  BuildContext context,
  GoRouterState state,
) {
  return _BasicRoutePage(
    key: state.pageKey,
    child: ErrorPage(
      // extraがないということは自動で呼び出されたということなので自動構築する
      extra: state.extra == null
          ? ErrorPageExtra(error: state.error)
          : state.extra! as ErrorPageExtra,
    ),
    transitionsBuilder: _fromBottom,
  );
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
        path: HomePageExtra.routingPath,
        pageBuilder: (context, state) => _BasicRoutePage(
          key: state.pageKey,
          child: HomePage(
            extra: state.extra! as HomePageExtra,
          ),
          transitionsBuilder: _fromRight,
        ),
      ),

      // エラー
      GoRoute(
        path: ErrorPageExtra.routingPath,
        pageBuilder: _buildErrorPage,
      ),
    ],

    // ルーティングに失敗した場合の画面
    errorPageBuilder: _buildErrorPage,
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
