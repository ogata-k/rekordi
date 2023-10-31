import 'package:flutter/widgets.dart';

/// ページのエクストラデータ
abstract class BasePageExtra {
  const BasePageExtra();

  /// 絶対パス。呼び出し先を指定するときに利用する。
  String get absolutePagePath;
}

/// コントローラーで扱うモデル
/// このモデルが自動的に更新をページに通知する形でリビルドを要求する
abstract class BasePageModel {}

/// ページのコントローラー
abstract class BasePageController<M extends BasePageModel> {
  const BasePageController(this._model);

  final M _model;

  M get model => _model;

  void start(BuildContext context);

  void dispose();
}

/// ページの基本となる抽象クラス
abstract class BasePage<E extends BasePageExtra, M extends BasePageModel,
    C extends BasePageController<M>> extends StatelessWidget {
  const BasePage({Key? key, required this.extra}) : super(key: key);

  final E extra;

  /// コントローラーの初期化
  C createController(E extra);

  /// アプリのライフサイクルハンドラ
  void didChangeAppLifecycleState(AppLifecycleState state);

  /// ページの描画
  Widget buildPage(BuildContext context, C controller);

  @override
  Widget build(BuildContext context) {
    return _HandlePageControllerWidget<E, M, C>(
      extra: this.extra,
      create: createController,
      didChangeAppLifecycleState: didChangeAppLifecycleState,
      build: buildPage,
    );
  }
}

/// PageControllerを扱うためのWidget
class _HandlePageControllerWidget<
    E extends BasePageExtra,
    M extends BasePageModel,
    C extends BasePageController<M>> extends StatefulWidget {
  const _HandlePageControllerWidget({
    Key? key,
    required this.extra,
    required this.create,
    required this.didChangeAppLifecycleState,
    required this.build,
  }) : super(key: key);

  final E extra;

  /// ページのcontextを使う
  final C Function(E extra) create;

  /// ページのcontextを使う
  final Widget Function(BuildContext context, C state) build;

  /// アプリのライフサイクルハンドラ
  final void Function(AppLifecycleState state) didChangeAppLifecycleState;

  @override
  _HandlePageControllerWidgetState<E, M, C> createState() =>
      _HandlePageControllerWidgetState<E, M, C>();
}

class _HandlePageControllerWidgetState<E extends BasePageExtra,
        M extends BasePageModel, C extends BasePageController<M>>
    extends State<_HandlePageControllerWidget<E, M, C>>
    with WidgetsBindingObserver {
  late C state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    state = widget.create(widget.extra);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.start(context);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    state.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, state);
  }
}
