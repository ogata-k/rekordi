import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' as gr;
import 'package:rekordi/domain/component/interface/router.dart' as dc;
import 'package:rekordi/util/error.dart';

/// AppRouterで扱える形式に変換するための具象クラス
class ComponentGoRouter implements dc.Router {
  ComponentGoRouter();

  @override
  Future<T?> push<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  ) =>
      gr.GoRouter.of(context).push<T>(path, extra: extra);

  @override
  Future<T?> pushWithReplace<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  ) =>
      gr.GoRouter.of(context).pushReplacement(path, extra: extra);

  @override
  Future<T?> pushWithClearStack<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  ) {
    // @todo Not Support
    throw NotSupportError(
      description: 'Not Support this implement by go_router: 9.0.0',
    );
  }

  @override
  bool canPop(BuildContext context) => gr.GoRouter.of(context).canPop();

  @override
  void pop<T extends Object>(BuildContext context, [T? result]) =>
      gr.GoRouter.of(context).pop(result);

  @override
  void popUntilThePath(BuildContext context, List<String> pathList) {
    // @todo Not Support
    throw NotSupportError(
      description: 'Not Support this implement by go_router: 9.0.0',
    );
  }

  @override
  void popUntilTheName(BuildContext context, List<String> nameList) {
    // @todo Not Support
    throw NotSupportError(
      description: 'Not Support this implement by go_router: 9.0.0',
    );
  }

  @override
  void popUntilFirst(BuildContext context) {
    // @todo Not Support
    throw NotSupportError(
      description: 'Not Support this implement by go_router: 9.0.0',
    );
  }

  @override
  void closeDialog<T extends Object>(BuildContext context, [T? result]) =>
      Navigator.of(context).pop(result);
}
