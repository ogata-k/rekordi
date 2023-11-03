import 'dart:async';

import 'package:rekordi/domain/component/interface/event_bus.dart';
import 'package:rekordi/domain/component/locator.dart';

/// 簡単に扱うためのヘルパ
AppEventBus eventBus() => locator().get<AppEventBus>();

/// アプリのルーティングを担うルーター
class AppEventBus {
  const AppEventBus(this._instance);

  final IEventBus _instance;

  /// Eventを発火させる
  void fire<T>(T event) {
    _instance.fire<T>(event);
  }

  /// Eventを監視する
  StreamSubscription<T> listen<T>(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _instance.listen<T>(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
