import 'package:rekordi/domain/component/event_bus.dart' as ceb;
import 'package:state_notifier/state_notifier.dart';

/// ページのコントローラー
abstract class IPageController<Model> extends StateNotifier<Model> {
  IPageController(super._state);

  /// 自分の実行したアクションに関してほかのControllerにイベントを通知する。
  /// また、ほかのControllerで通知されるイベントを監視する。
  ceb.AppEventBus get eventBus => ceb.eventBus();
}
