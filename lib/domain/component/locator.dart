import 'dart:async';

import 'package:rekordi/domain/component/interface/locator.dart';
import 'package:rekordi/util/error/not_initialize_error.dart';

/// 簡単に扱うためのヘルパ
AppLocator locator() => AppLocator();

/// このアプリ用のサービスロケーターのロケータークラス
class AppLocator {
  static ILocator _instance = throw NotInitializeError(
    description: 'Not initialized AppLocator inner instance',
  );

  /// AppLocatorを初期化する
  // ignore: use_setters_to_change_properties
  static void initialize(ILocator locator) {
    _instance = locator;
  }

  /// 型やインスタンス名に対応する登録してあるインスタンスを同期的に取得してくる。
  /// 非同期インスタンスは準備済みなら取得できるが、まだ準備できていない場合はエラーになる。
  T get<T extends Object>({String? instanceName}) =>
      _instance.get(instanceName: instanceName);

  /// 型やインスタンス名に対応する登録してあるインスタンスを非同期的に取得してくる。
  Future<T> getAsync<T extends Object>({String? instanceName}) =>
      _instance.getAsync(instanceName: instanceName);

  /// このメソッドを呼び出すまでに登録したすべてのインスタンスの準備を完了させる。
  Future<void> waitToAllOk() => _instance.waitToAllOk();

  /// 型やインスタンス名に対応する登録してあるインスタンスの準備を完了させる。
  Future<void> waitToOk<T extends Object>({String? instanceName}) async {
    await _instance.getAsync<T>(instanceName: instanceName);
  }

  /// 毎回新規インスタンスを構築して返す形で登録する。
  void registerEveryTimeNewInstance<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) =>
      _instance.registerEveryTimeNewInstance<T>(
        factoryFunc,
        instanceName: instanceName,
      );

  /// 毎回新規インスタンスを構築して返す形で登録する。
  /// [getAsync]でしか取得できない。
  void registerAsyncEveryTimeNewInstance<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
  }) =>
      _instance.registerAsyncEveryTimeNewInstance<T>(
        factoryFunc,
        instanceName: instanceName,
      );

  /// 同期的に取得できるインスタンスをシングルトンで登録する。
  void registerSingleton<T extends Object>(FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) =>
      _instance.registerSingleton<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );

  /// 非同期的に取得できるインスタンスをシングルトンで登録する。
  /// 準備を完了させておくことで、同期的にも取得できる。
  void registerAsyncSingleton<T extends Object>(FactoryFuncAsync<T> factoryFunc,
      {
        String? instanceName,
        DisposingFunc<T>? dispose,
      }) =>
      _instance.registerAsyncSingleton<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );
}
