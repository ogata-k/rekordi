import 'dart:async';

/// 一度処理した値を保持しておける[StreamController]
class CacheValueStreamController<T> {
  CacheValueStreamController(this._controller, T initialValue)
      : _currentValue = initialValue;

  final StreamController<T> _controller;

  Stream<T> get stream => _controller.stream;

  T _currentValue;

  T get currentValue => _currentValue;

  void add(T event) {
    _currentValue = event;
    return _controller.sink.add(event);
  }

  void addError(Object error, [StackTrace? stackTrace]) {
    return _controller.sink.addError(error, stackTrace);
  }

  Future<dynamic> addStream(Stream<T> stream) {
    return _controller.sink.addStream(stream);
  }

  Future<dynamic> close() {
    return _controller.close();
  }
}

extension StreamControllerCacheValueExt<T> on StreamController<T> {
  CacheValueStreamController<T> withCache(T initialValue) =>
      CacheValueStreamController<T>(this, initialValue);

  CacheValueStreamController<T?> withCacheOrNull(T? initialValue) =>
      CacheValueStreamController<T?>(this, initialValue);
}
