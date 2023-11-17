import 'package:flutter/foundation.dart';
import 'package:rekordi/domain/component/event_bus.dart';
import 'package:rekordi/domain/component/interface/event_bus.dart';
import 'package:rekordi/domain/component/interface/logger.dart';
import 'package:rekordi/domain/component/interface/router.dart';
import 'package:rekordi/domain/component/locator.dart';
import 'package:rekordi/domain/component/logger.dart';
import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/infra/component/event_bus.dart';
import 'package:rekordi/infra/component/locator.dart';
import 'package:rekordi/infra/component/logger.dart';
import 'package:rekordi/infra/component/router.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';

/// テストの実行などでも変わらないAppLocator関連の初期化を行う
class InitializeLocatorUsecase extends BaseUsecase {
  void call() {
    AppLocator.initialize(GetItLocator());

    locator()
      ..registerSingleton<AppLogger>(
        () {
          final ILogger logger = LoggingLogger();
          return AppLogger(logger)
            ..initialize(
              kReleaseMode ? LogLevel.info : LogLevel.fine,
              true,
            );
        },
      )
      ..registerSingleton<AppRouter>(
        () {
          final IRouter router = GoRouterImpl();
          return AppRouter(router);
        },
      )
      ..registerSingleton<AppEventBus>(
        () {
          final IEventBus eventBus = EventBus(true);
          return AppEventBus(eventBus);
        },
      );

    logger().info('Finished initialize Locator', {});
  }
}
