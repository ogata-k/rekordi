import 'dart:async';

import 'package:rekordi/infra/component/locator.dart';

typedef FactoryFunc<T> = T Function();
typedef FactoryFuncAsync<T> = Future<T> Function();
typedef DisposingFunc<T> = FutureOr<void> Function(T arg);

/// このアプリ用のサービスロケーターのロケータークラス
class AppLocator extends Locator {
  static Locator _instance = GetItLocator();

  /// テスト時にデフォルト以外のインスタンスを利用したい場合に置き換える
  // ignore: use_setters_to_change_properties
  void asMock(Locator mockInstance) {
    _instance = mockInstance;
  }

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
  void registerEveryTimeNewInstance<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) =>
      _instance.registerEveryTimeNewInstance<T>(
        factoryFunc,
        instanceName: instanceName,
      );

  @override
  void registerAsyncEveryTimeNewInstance<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
  }) =>
      _instance.registerAsyncEveryTimeNewInstance<T>(
        factoryFunc,
        instanceName: instanceName,
      );

  @override
  void registerSingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) =>
      _instance.registerSingleton<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );

  @override
  void registerAsyncSingleton<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
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
  /// テスト用にする
  void asTest();

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
