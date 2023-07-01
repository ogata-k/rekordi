import 'package:flutter/widgets.dart';
import 'package:rekordi/component/locator.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';

/// アプリを初期化するためのユースケース
class InitializeAppUsecase extends BaseUsecase {
  Future<void> call({bool minimize = false}) async {
    WidgetsFlutterBinding.ensureInitialized();

    // @todo サービスクラスなどの登録が必用ならここでAppLocatorに登録する

    await AppLocator().waitToAllOk();
  }
}
