import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/presentation/page/error/route_setting.dart';
import 'package:rekordi/presentation/page/error/view.dart';
import 'package:rekordi/presentation/page/home/route_setting.dart';
import 'package:rekordi/presentation/page/home/view.dart';

/// ルーティング情報を取得
GoRouter getRouter() {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,

    // 初期値
    initialLocation:
        HomePageRouteSetting(pageTitle: null).toRouteSetting().toLocation(),

    // ルーティング一覧
    routes: <RouteBase>[
      GoRoute(
        path: HomePageRouteSetting.routePath,
        pageBuilder: (context, state) {
          final params = HomePageRouteSetting.fromPathParams(
            state.pathParameters,
            state.uri.queryParametersAll,
          );

          return _navigateForPlatform(
            key: state.pageKey,
            fullscreenDialog: false,
            child: HomePage(
              pageTitle: params.pageTitle,
            ),
          );
        },
      ),

      // エラー
      GoRoute(
        path: ErrorPageRouteSetting.routePath,
        pageBuilder: (context, state) {
          final params = ErrorPageRouteSetting.fromPathParams(
            state.pathParameters,
            state.uri.queryParametersAll,
          );

          return _navigateForPlatform(
            key: state.pageKey,
            fullscreenDialog: true,
            child: ErrorPage(
              error: params.error,
            ),
          );
        },
      ),
    ],

    // ルーティングに失敗した場合の画面
    errorPageBuilder: (context, state) {
      return _navigateForPlatform(
        key: state.pageKey,
        fullscreenDialog: true,
        child: ErrorPage(
          error: state.error?.toString(),
        ),
      );
    },
  );
}

/// プラトフォームごとに表示するPageRouteを振り分ける。
/// [fullscreenDialog]で変化する挙動は[ThemeData.pageTransitionsTheme]を参照のこと。
Page<T> _navigateForPlatform<T>({
  LocalKey? key,
  required bool fullscreenDialog,
  bool allowSnapshotting = true,
  required Widget child,
}) {
  if (Platform.isIOS || Platform.isMacOS) {
    return CupertinoPage<T>(
      key: key,
      maintainState: true,
      fullscreenDialog: fullscreenDialog,
      allowSnapshotting: allowSnapshotting,
      child: child,
    );
  }

  return _MyMaterialPage<T>(
    key: key,
    maintainState: true,
    fullscreenDialog: fullscreenDialog,
    allowSnapshotting: allowSnapshotting,
    child: child,
  );
}

/// 実装自体は[MaterialPage]と同じだが、カスタムできるように調整したPageRouteを返すようにしてある。
class _MyMaterialPage<T> extends MaterialPage<T> {
  const _MyMaterialPage({
    required super.child,
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.allowSnapshotting = true,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return _MyPageBasedMaterialPageRoute<T>(
      page: this,
      allowSnapshotting: allowSnapshotting,
    );
  }
}

/// 実装自体は[MaterialPage]で返しているPageRouteのレスポンスと同じだが、
/// [transitionDuration]をデフォルトの300msより遅めに設定してある。
class _MyPageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  _MyPageBasedMaterialPageRoute({
    required MaterialPage<T> page,
    super.allowSnapshotting,
  }) : super(settings: page) {
    assert(opaque);
  }

  MaterialPage<T> get _page => settings as MaterialPage<T>;

  @override
  Widget buildContent(BuildContext context) {
    return _page.child;
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 450);
}
