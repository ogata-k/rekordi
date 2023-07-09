import 'dart:async';

import 'package:rekordi/util/error.dart';

typedef FactoryFunc<T> = T Function();
typedef FactoryFuncAsync<T> = Future<T> Function();
typedef DisposingFunc<T> = FutureOr<void> Function(T arg);

/// 簡単に扱うためのヘルパ
AppLocator locator() => AppLocator();

/// このアプリ用のサービスロケーターのロケータークラス
class AppLocator {
  static Locator _instance = throw NotInitializeError(
    description: 'Not initialized AppLocator inner instance',
  );

  /// AppLocatorを初期化する
  // ignore: use_setters_to_change_properties
  static void initialize(Locator locator) {
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

/// サービスロケータのロケーター抽象クラス
abstract class Locator {
  /// 登録したシングルトンインスタンスを取得する
  T get<T extends Object>({String? instanceName});

  /// 登録したシングルトンインスタンスを取得する
  Future<T> getAsync<T extends Object>({String? instanceName});

  /// 非同期のビルダーを構築を実行して、すべて完了にする
  Future<void> waitToAllOk();

  /// 呼び出すたびにインスタンスを構築して返すクラスを登録する
  void registerEveryTimeNewInstance<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  });

  /// 呼び出すたびに非同期なインスタンスを構築して返すクラスを登録する
  ///
  /// ※　[getAsync]でしか取得できないので注意
  void registerAsyncEveryTimeNewInstance<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
  });

  /// シングルトンを登録する
  void registerSingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });

  /// 非同期に作成するシングルトンを登録する
  ///
  /// ※　[waitToAllOk]で待っていれば[get]で取得できるが、待っていないなら[getAsync]でしか取得できないので注意
  void registerAsyncSingleton<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });
}
