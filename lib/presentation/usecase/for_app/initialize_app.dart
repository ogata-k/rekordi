import 'package:flutter/foundation.dart';
import 'package:rekordi/component/locator.dart';
import 'package:rekordi/component/logger.dart';
import 'package:rekordi/component/logger.dart' as component_logger;
import 'package:rekordi/component/router.dart';
import 'package:rekordi/component/router.dart' as component_router;
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

    AppLocator()
      // ここからはコンポーネント用のインフラの登録
      ..registerSingleton<component_logger.Logger>(LoggingLogger.new)
      ..registerSingleton<component_router.Router>(ComponentGoRouter.new)
      // ここからはリポジトリ用のインフラの登録
      ..registerAsyncSingleton<Preferences>(SharedPreferences.buildInstance)
      ..registerSingleton<LocalDatabase>(
        InfraLocalDatabase.buildInstance,
        dispose: (db) async => await db.close(),
      )
      // ここからはコンポーネント(これらは全体的に使うのでヘルパが用意されている)
      ..registerSingleton<AppLogger>(
        () => AppLogger(AppLocator().get<component_logger.Logger>())
          ..initialize(kReleaseMode ? LogLevel.info : LogLevel.debug, true),
      )..registerSingleton<AppRouter>(
          () => AppRouter(AppLocator().get<component_router.Router>()),
    )
    // ここからはRepositoryの登録
      ..registerAsyncSingleton<PreferencesRepository>(
            () async {
          return PreferencesRepository(
            await AppLocator().getAsync<Preferences>(),
          );
        },
      )
      ..registerSingleton<BookRepository>(
            () =>
            BookRepository(
              dbRepository: AppLocator()
                  .get<LocalDatabase>()
                  .bookDbRepository,
            ),
      )..registerSingleton<FootprintRepository>(
          () =>
          FootprintRepository(
            dbRepository: AppLocator()
                .get<LocalDatabase>()
                .footprintDbRepository,
          ),
    );

    // 下記は非同期だが初期化が完了していて欲しいので、初期化が完了するまで待つ
    await AppLocator().waitToOk<PreferencesRepository>();

    logger().info('Finished initialize', {'minimize': minimize});
  }
}
