import 'package:flutter/widgets.dart';
import 'package:rekordi/component/locator.dart';
import 'package:rekordi/domain/repository/preferences.dart';
import 'package:rekordi/infra/preferences/preferences.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';

/// アプリを初期化するためのユースケース
class InitializeAppUsecase extends BaseUsecase {
  Future<void> call({bool minimize = false}) async {
    WidgetsFlutterBinding.ensureInitialized();

    AppLocator().registerAsyncSingleton<PreferencesRepository>(
      () async {
        return PreferencesRepository(await SharedPreferences.buildInstance());
      },
    );
    await AppLocator().waitToAllOk();
    // 全体で使用するような非同期はここまで。ここからは全体で使用しないような非同期
    // @todo サービスクラスなどの登録が必用ならここでAppLocatorに登録する
    // 全体で使用しないような非同期はここまで。ここからは全体で使用しないような同期
    // @todo サービスクラスなどの登録が必用ならここでAppLocatorに登録する
  }
}
