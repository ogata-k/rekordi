import 'package:rekordi/domain/component/locator.dart';
import 'package:rekordi/domain/component/logger.dart';
import 'package:rekordi/domain/repository/db/book.dart';
import 'package:rekordi/domain/repository/db/footprint.dart';
import 'package:rekordi/domain/repository/db/interface/local_database.dart';
import 'package:rekordi/domain/repository/file/interface/preferences.dart';
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/infra/component/locator.dart';
import 'package:rekordi/infra/repository/db/database.dart';
import 'package:rekordi/infra/repository/file/preferences.dart';
import 'package:rekordi/presentation/usecase/usecase.dart';

/// アプリを初期化するためのユースケース
class InitializeAppAsyncUsecase extends IUsecase {
  Future<void> call() async {
    AppLocator.initialize(GetItLocator());

    locator()
      //
      // ここからはリポジトリ用のインフラの登録
      //
      ..registerAsyncSingleton<IPreferences>(SharedPreferences.buildInstance)
      ..registerSingleton<ILocalDatabase>(
        InfraLocalDatabase.buildInstance,
        dispose: (db) async => await db.close(),
      )
      //
      // ここからはRepositoryの登録
      //
      ..registerAsyncSingleton<PreferencesRepository>(
        () async {
          return PreferencesRepository(
            await locator().getAsync<IPreferences>(),
          );
        },
      )
      ..registerSingleton<BookDbRepository>(
        () => BookDbRepository(
          dbRepository: locator().get<ILocalDatabase>().bookDbRepository,
        ),
      )
      ..registerSingleton<FootprintDbRepository>(
        () => FootprintDbRepository(
          dbRepository: locator().get<ILocalDatabase>().footprintDbRepository,
        ),
      );

    // 下記は非同期だが初期化が完了していて欲しいので、初期化が完了するまで待つ
    await locator().waitToOk<PreferencesRepository>();

    logger().info('Finished initialize App', {});
  }
}
