import 'package:flutter/widgets.dart';
import 'package:rekordi/domain/component/event_bus.dart' as ceb;
import 'package:rekordi/presentation/page/model.dart';

/// ページのコントローラー
abstract class IPageController<M extends IPageModel> {
  const IPageController(this._model);

  final M _model;

  M get model => _model;

  /// 自分の実行したアクションに関してほかのControllerにイベントを通知する。
  /// また、ほかのControllerで通知されるイベントを監視する。
  ceb.AppEventBus get eventBus => ceb.eventBus();

  void start(BuildContext context);

  void dispose();
}
