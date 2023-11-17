import 'package:flutter/widgets.dart';

abstract class IRouter {
  /// 指定されたパスをもとに遷移する。
  Future<T?> push<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  );

  /// 指定されたパスに遷移する。このとき遷移と同時にこれまでの履歴を削除する。
  void go(
    BuildContext context,
    String path,
    Object extra,
  );

  /// 指定されたパスに遷移元を置き換えながら遷移する。
  Future<T?> pushReplacement<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  );

  /// 画面が取り除くことができるならtrue
  bool canPop(BuildContext context);

  /// 画面を取り除く
  void pop<T extends Object>(BuildContext context, [T? result]);

  /// 画面一番上のダイアログを取り除く
  void closeDialog<T extends Object>(BuildContext context, [T? result]);
}
