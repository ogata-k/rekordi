import 'dart:async';

typedef FactoryFunc<T> = T Function();
typedef FactoryFuncAsync<T> = Future<T> Function();
typedef DisposingFunc<T> = FutureOr<void> Function(T arg);

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
