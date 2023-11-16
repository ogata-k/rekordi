import 'package:flutter/widgets.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:rekordi/presentation/page/controller.dart';

export 'package:provider/provider.dart' show Consumer, Selector;

/// ページのエクストラデータ
abstract class IPageExtra {
  const IPageExtra();

  /// 絶対パス。呼び出し先を指定するときに利用する。
  String get absolutePagePath;
}

/// ページの基本となる抽象クラス
abstract class IPage<Extra extends IPageExtra, Model,
    Controller extends IPageController<Model>> extends StatelessWidget {
  const IPage({super.key, required this.extra});

  final Extra extra;

  /// コントローラーの初期化
  Controller createController(BuildContext context);

  /// buildPageに渡すControllerに依存しないWidget
  Widget? buildChild(BuildContext context) => null;

  /// ページの描画
  Widget buildPage(BuildContext context, Widget? child);

  /// buildPage内で利用できるControllerのgetter
  Controller getController(BuildContext context) => context.read<Controller>();

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<Controller, Model>(
      create: createController,
      builder: buildPage,
      child: buildChild(context),
    );
  }
}
