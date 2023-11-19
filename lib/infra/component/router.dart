import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' as gr;
import 'package:rekordi/domain/component/interface/router.dart' as dc;

/// AppRouterで扱える形式に変換するための具象クラス
class GoRouterImpl extends dc.IRouter {
  GoRouterImpl();

  @override
  Future<T?> push<T extends Object?>(
    BuildContext context,
    String location,
  ) =>
      gr.GoRouter.of(context).push<T>(location);

  @override
  void go(
    BuildContext context,
    String location,
  ) =>
      gr.GoRouter.of(context).go(location);

  @override
  Future<T?> pushReplacement<T extends Object?>(
    BuildContext context,
    String location,
  ) =>
      gr.GoRouter.of(context).pushReplacement<T>(location);

  @override
  bool canPop(BuildContext context) => gr.GoRouter.of(context).canPop();

  @override
  void pop<T extends Object>(BuildContext context, [T? result]) =>
      gr.GoRouter.of(context).pop(result);

  @override
  void closeDialog<T extends Object>(BuildContext context, [T? result]) =>
      Navigator.of(context, rootNavigator: true).pop(result);
}
