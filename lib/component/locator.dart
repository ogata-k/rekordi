import 'dart:async';

import 'package:rekordi/infra/component/locator.dart';

typedef FactoryFunc<T> = T Function();
typedef FactoryFuncAsync<T> = Future<T> Function();
typedef DisposingFunc<T> = FutureOr<void> Function(T arg);

/// このアプリ用のサービスロケーターのロケータークラス
class AppLocator extends Locator {
  static final Locator _instance = GetItLocator();

  @override
  void asTest() => _instance.asTest();

  @override
  T get<T extends Object>({String? instanceName}) =>
      _instance.get(instanceName: instanceName);

  @override
  Future<T> getAsync<T extends Object>({String? instanceName}) =>
      _instance.getAsync(instanceName: instanceName);

  @override
  Future<void> waitToAllOk() => _instance.waitToAllOk();

  @override
  void registerNewInstanceEveryTime<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) =>
      _instance.registerNewInstanceEveryTime<T>(
        factoryFunc,
        instanceName: instanceName,
      );

  @override
  void registerNewInstanceAsyncEveryTime<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
  }) =>
      _instance.registerNewInstanceAsyncEveryTime<T>(
        factoryFunc,
        instanceName: instanceName,
      );

  @override
  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) =>
      _instance.registerLazySingleton<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );

  @override
  void registerLazySingletonAsync<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) =>
      _instance.registerLazySingletonAsync<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );
}

/// サービスロケータのロケーター抽象クラス
abstract class Locator {
  /// テスト用にする
  void asTest();

  /// 登録したシングルトンインスタンスを取得する
  T get<T extends Object>({String? instanceName});

  /// 登録したシングルトンインスタンスを取得する
  Future<T> getAsync<T extends Object>({String? instanceName});

  /// 非同期のビルダーを構築を実行して、すべて完了にする
  Future<void> waitToAllOk();

  /// 呼び出すたびにインスタンスを構築して返すクラスを登録する
  void registerNewInstanceEveryTime<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  });

  /// 呼び出すたびに非同期なインスタンスを構築して返すクラスを登録する
  void registerNewInstanceAsyncEveryTime<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
  });

  /// シングルトンを登録する
  /// 初めて呼び出したときにシングルトンを構築する
  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });

  /// 非同期なシングルトンを登録する
  /// 初めて呼び出したときにシングルトンを構築する。
  ///
  /// ※　[getAsync]でしか取得できないので注意
  void registerLazySingletonAsync<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });
}
