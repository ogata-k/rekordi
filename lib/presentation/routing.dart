import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/presentation/page/error/route_setting.dart';
import 'package:rekordi/presentation/page/error/view.dart';
import 'package:rekordi/presentation/page/home/route_setting.dart';
import 'package:rekordi/presentation/page/home/view.dart';

/// クエリパラメータをパースして値を取得する。
T? _getParam<T>(
  Map<String, String> params,
  String key,
  T? Function(String value) tryParse,
) {
  final String? value = params[key] == '' ? null : params[key];
  if (value == null) {
    return null;
  }

  return tryParse(value);
}

/// ルーティング情報を取得
GoRouter getRouter() {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,

    // 初期値
    initialLocation: HomePageRouteSetting(pageTitle: null).toInitialLocation(),

    // ルーティング一覧
    routes: <RouteBase>[
      GoRoute(
        name: HomePageRouteSetting.routeName,
        path: HomePageRouteSetting.routePath,
        pageBuilder: (context, state) => _BasicRoutePage(
          key: state.pageKey,
          child: HomePage(
            pageTitle: _getParam(
              state.uri.queryParameters,
              HomePageRouteSetting.pageTitleQueryKey,
              (value) => value,
            ),
          ),
          transitionsBuilder: _fromRight,
        ),
      ),

      // エラー
      GoRoute(
        name: ErrorPageRouteSetting.routeName,
        path: ErrorPageRouteSetting.routePath,
        pageBuilder: (context, state) => _BasicRoutePage(
          key: state.pageKey,
          child: ErrorPage(
            error: _getParam(
              state.uri.queryParameters,
              ErrorPageRouteSetting.errorQueryKey,
              (value) => value,
            ),
          ),
          transitionsBuilder: _fromBottom,
        ),
      ),
    ],

    // ルーティングに失敗した場合の画面
    errorPageBuilder: (context, state) => _BasicRoutePage(
      key: state.pageKey,
      child: ErrorPage(
        error: state.error?.toString(),
      ),
      transitionsBuilder: _fromBottom,
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
Widget _fadeIn(BuildContext context,
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
Widget _fromRight(BuildContext context,
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
Widget _fromBottom(BuildContext context,
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
Widget _fadeInPopToBottom(BuildContext context,
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
