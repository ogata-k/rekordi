import 'package:get_it/get_it.dart' as get_it;
import 'package:rekordi/domain/domain_component/locator.dart';

/// サービスロケータのロケータークラス
class GetItLocator extends Locator {
  get_it.GetIt get _instance => get_it.GetIt.instance;

  @override
  T get<T extends Object>({String? instanceName}) =>
      _instance.get<T>(instanceName: instanceName);

  @override
  Future<T> getAsync<T extends Object>({String? instanceName}) =>
      _instance.getAsync<T>(instanceName: instanceName);

  @override
  Future<void> waitToAllOk() async {
    await _instance.allReady();
  }

  @override
  void registerSingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    _instance.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void registerAsyncSingleton<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    // 初取得時に初期化を完了するLazyを使う方法だとLocator初期化のタイミングで[allReady]で待つ対象にできない。
    // そのため、初期化が完了するまで待てるようにNot Lazyで登録する。
    _instance.registerSingletonAsync<T>(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void registerEveryTimeNewInstance<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _instance.registerFactory<T>(factoryFunc, instanceName: instanceName);
  }

  @override
  void registerAsyncEveryTimeNewInstance<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
  }) {
    _instance.registerFactoryAsync<T>(factoryFunc, instanceName: instanceName);
  }
}
