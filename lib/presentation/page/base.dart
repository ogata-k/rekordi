import 'package:flutter/widgets.dart';

/// ページのエクストラデータ
abstract class BasePageExtra {
  const BasePageExtra();

  /// 絶対パス。呼び出し先を指定するときに利用する。
  String get absolutePagePath;
}

/// ページのコントローラー
abstract class BasePageController {
  const BasePageController();

  void dispose();
}

/// ページの基本となる抽象クラス
abstract class BasePage<E extends BasePageExtra, C extends BasePageController>
    extends StatelessWidget {
  const BasePage({Key? key, required this.extra}) : super(key: key);

  final E extra;

  /// コントローラーの初期化
  C createController(BuildContext context);

  /// ページの描画
  Widget buildPage(BuildContext context, C controller);

  @override
  Widget build(BuildContext context) {
    return _DisposablePageState<C>(
      create: () => createController(context),
      dispose: (state) => state.dispose(),
      build: (state) {
        return buildPage(context, state);
      },
    );
  }
}

/// disposeを自動実行するPage用Widget
class _DisposablePageState<S extends Object> extends StatefulWidget {
  const _DisposablePageState({
    Key? key,
    required this.create,
    required this.dispose,
    required this.build,
  }) : super(key: key);

  /// ページのcontextを使う
  final S Function() create;
  final void Function(S state) dispose;

  /// ページのcontextを使う
  final Widget Function(S state) build;

  @override
  _DisposablePageStateState<S> createState() => _DisposablePageStateState<S>();
}

class _DisposablePageStateState<S extends Object>
    extends State<_DisposablePageState<S>> {
  late S state;

  @override
  void initState() {
    super.initState();
    state = widget.create();
  }

  @override
  void dispose() {
    widget.dispose(state);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(state);
  }
}
