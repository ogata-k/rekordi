import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rekordi/component/router.dart' as component;

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
