import 'dart:async';

import 'package:event_bus/event_bus.dart' as peb;
import 'package:rekordi/domain/component/interface/event_bus.dart';

class EventBus extends IEventBus {
  // ignore: avoid_positional_boolean_parameters
  EventBus(bool sync) : _bus = peb.EventBus(sync: sync);

  final peb.EventBus _bus;

  @override
  void fire<T>(T event) {
    _bus.fire(event);
  }

  @override
  StreamSubscription<T> listen<T>(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _bus.on<T>().listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
  }
}
