import 'package:get_it/get_it.dart' as get_it;
import 'package:rekordi/component/locator.dart';

/// サービスロケータのロケータークラス
class GetItLocator extends Locator {
  get_it.GetIt get _instance => get_it.GetIt.instance;

  @override
  void asTest() {
    _instance.allowReassignment = true;
  }

  @override
  T get<T extends Object>({String? instanceName}) {
    if (!_instance.isReadySync(instanceName: instanceName)) {
      _instance.allReadySync();
    }

    return _instance.get<T>(instanceName: instanceName);
  }

  @override
  Future<T> getAsync<T extends Object>({String? instanceName}) =>
      _instance.getAsync<T>(instanceName: instanceName);

  @override
  Future<void> waitToAllOk() async {
    await _instance.allReady();
  }

  @override
  void registerLazySingleton<T extends Object>(
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
  void registerLazySingletonAsync<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    _instance.registerLazySingletonAsync<T>(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void registerNewInstanceEveryTime<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _instance.registerFactory<T>(factoryFunc, instanceName: instanceName);
  }

  @override
  void registerNewInstanceAsyncEveryTime<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
  }) {
    _instance.registerFactoryAsync<T>(factoryFunc, instanceName: instanceName);
  }
}
