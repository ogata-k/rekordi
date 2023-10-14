import 'package:flutter/foundation.dart';
import 'package:rekordi/component/locator.dart';
import 'package:rekordi/component/logger.dart' as c_logger;
import 'package:rekordi/component/router.dart' as c_router;
import 'package:rekordi/domain/domain_component/logger.dart' as dc_logger;
import 'package:rekordi/domain/domain_component/router.dart' as dc_router;
import 'package:rekordi/domain/domain_infra/local_database.dart';
import 'package:rekordi/domain/domain_infra/preferences.dart';
import 'package:rekordi/domain/repository/book.dart';
import 'package:rekordi/domain/repository/footprint.dart';
import 'package:rekordi/domain/repository/preferences.dart';
import 'package:rekordi/infra/component/locator.dart';
import 'package:rekordi/infra/component/logger.dart' show LoggingLogger;
import 'package:rekordi/infra/component/router.dart';
import 'package:rekordi/infra/local_db/database.dart';
import 'package:rekordi/infra/preferences/preferences.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';

/// アプリを初期化するためのユースケース
class InitializeAppUsecase extends BaseUsecase {
  Future<void> call({bool minimize = false}) async {
    AppLocator.initialize(GetItLocator());

    locator()
      //
      // ここからはコンポーネント用のインフラの登録
      //
      ..registerSingleton<dc_logger.Logger>(LoggingLogger.new)
      ..registerSingleton<dc_router.Router>(ComponentGoRouter.new)
      //
      // ここからはリポジトリ用のインフラの登録
      //
      ..registerAsyncSingleton<Preferences>(SharedPreferences.buildInstance)
      ..registerSingleton<LocalDatabase>(
        InfraLocalDatabase.buildInstance,
        dispose: (db) async => await db.close(),
      )
      //
      // ここからはコンポーネント(これらは全体的に使うのでヘルパが用意されている)
      //
      ..registerSingleton<c_logger.AppLogger>(
        () => c_logger.AppLogger(locator().get<dc_logger.Logger>())
          ..initialize(
            kReleaseMode ? dc_logger.LogLevel.info : dc_logger.LogLevel.debug,
            true,
          ),
      )
      ..registerSingleton<c_router.AppRouter>(
        () => c_router.AppRouter(locator().get<dc_router.Router>()),
      )
      //
      // ここからはRepositoryの登録
      //
      ..registerAsyncSingleton<PreferencesRepository>(
        () async {
          return PreferencesRepository(
            await locator().getAsync<Preferences>(),
          );
        },
      )
      ..registerSingleton<BookRepository>(
        () => BookRepository(
          dbRepository: locator().get<LocalDatabase>().bookDbRepository,
        ),
      )
      ..registerSingleton<FootprintRepository>(
        () => FootprintRepository(
          dbRepository: locator().get<LocalDatabase>().footprintDbRepository,
        ),
      );

    // 下記は非同期だが初期化が完了していて欲しいので、初期化が完了するまで待つ
    await locator().waitToOk<PreferencesRepository>();

    c_logger.logger().info('Finished initialize', {'minimize': minimize});
  }
}
