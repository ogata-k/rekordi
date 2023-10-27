import 'package:flutter/widgets.dart';

abstract interface class IRouter {
  /// 指定された[extra]を解析して得られたパスをもとに遷移する。
  Future<T?> push<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  );

  /// 指定された[extra]を解析して得られたパスをもとに遷移する。
  /// 遷移元を置き換えながら遷移する。
  Future<T?> pushWithReplace<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  );

  /// 指定された[extra]を解析して得られたパスをもとに遷移する。
  /// 画面のスタックを全部削除して遷移する。
  Future<T?> pushWithClearStack<T extends Object?>(
    BuildContext context,
    String path,
    Object extra,
  );

  /// 画面が取り除くことができるならtrue
  bool canPop(BuildContext context);

  /// 画面を取り除く
  void pop<T extends Object>(BuildContext context, [T? result]);

  /// 指定された[pathList]の中のパスになるまで画面を取り除く
  void popUntilThePath(BuildContext context, List<String> pathList);

  /// 指定された[nameList]の中のルーティング名になるまで画面を取り除く
  void popUntilTheName(BuildContext context, List<String> nameList);

  /// 最初の画面まで取り除く
  void popUntilFirst(BuildContext context);

  /// 画面一番上のダイアログを取り除く
  void closeDialog<T extends Object>(BuildContext context, [T? result]);
}
