import 'dart:async';

/// イベントをライフサイクルを考慮せずに通知する抽象クラス
abstract class IEventBus {
  void fire<T>(T event);

  StreamSubscription<T> listen<T>(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });
}
