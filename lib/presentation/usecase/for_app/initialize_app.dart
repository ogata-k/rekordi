import 'package:flutter/foundation.dart';
import 'package:rekordi/domain/component/event_bus.dart' as c_event_bus;
import 'package:rekordi/domain/component/interface/event_bus.dart'
    as dc_event_bus;
import 'package:rekordi/domain/component/interface/logger.dart' as dc_logger;
import 'package:rekordi/domain/component/interface/router.dart' as dc_router;
import 'package:rekordi/domain/component/locator.dart';
import 'package:rekordi/domain/component/logger.dart' as c_logger;
import 'package:rekordi/domain/component/router.dart' as c_router;
import 'package:rekordi/domain/repository/db/book.dart';
import 'package:rekordi/domain/repository/db/footprint.dart';
import 'package:rekordi/domain/repository/db/interface/local_database.dart';
import 'package:rekordi/domain/repository/file/interface/preferences.dart';
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/infra/component/event_bus.dart';
import 'package:rekordi/infra/component/locator.dart';
import 'package:rekordi/infra/component/logger.dart' show LoggingLogger;
import 'package:rekordi/infra/component/router.dart';
import 'package:rekordi/infra/repository/db/database.dart';
import 'package:rekordi/infra/repository/file/preferences.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';

/// アプリを初期化するためのユースケース
class InitializeAppUsecase extends BaseUsecase {
  Future<void> call({bool minimize = false}) async {
    AppLocator.initialize(GetItLocator());

    locator()
      //
      // ここからはコンポーネント用のインフラの登録
      //
      ..registerSingleton<dc_logger.ILogger>(LoggingLogger.new)
      ..registerSingleton<dc_router.IRouter>(ComponentGoRouter.new)
      ..registerSingleton<dc_event_bus.IEventBus>(EventBus.new)
      //
      // ここからはリポジトリ用のインフラの登録
      //
      ..registerAsyncSingleton<IPreferences>(SharedPreferences.buildInstance)
      ..registerSingleton<ILocalDatabase>(
        InfraLocalDatabase.buildInstance,
        dispose: (db) async => await db.close(),
      )
      //
      // ここからはコンポーネント(これらは全体的に使うのでヘルパが用意されている)
      //
      ..registerSingleton<c_logger.AppLogger>(
        () => c_logger.AppLogger(locator().get<dc_logger.ILogger>())
          ..initialize(
            kReleaseMode ? dc_logger.LogLevel.info : dc_logger.LogLevel.debug,
            true,
          ),
      )
      ..registerSingleton<c_router.AppRouter>(
        () => c_router.AppRouter(locator().get<dc_router.IRouter>()),
      )
      ..registerSingleton<c_event_bus.AppEventBus>(
        () => c_event_bus.AppEventBus(locator().get<dc_event_bus.IEventBus>()),
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

    c_logger.logger().info('Finished initialize', {'minimize': minimize});
  }
}
