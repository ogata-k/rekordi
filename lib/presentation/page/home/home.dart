import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rekordi/domain/component/locator.dart';
import 'package:rekordi/domain/component/logger.dart';
import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/db/book.dart';
import 'package:rekordi/presentation/model/app_theme_mode.dart';
import 'package:rekordi/presentation/model/cache_value_stream_controller.dart';
import 'package:rekordi/presentation/page/base.dart';
import 'package:rekordi/presentation/page/error/error.dart';
import 'package:rekordi/presentation/resource/l10n/l10n.dart';
import 'package:rekordi/presentation/resource/theme/const/padding.dart';
import 'package:rekordi/presentation/resource/theme/theme.dart';
import 'package:rekordi/presentation/usecase/book/watch_all.dart';

// @todo 実際のページ

class HomePageExtra extends BasePageExtra {
  const HomePageExtra() : super();

  factory HomePageExtra.defaultExtra() => const HomePageExtra();

  static const routingPath = '/home';

  @override
  String get absolutePagePath => '/home';
}

class HomePageController extends BasePageController {
  HomePageController(int initialCount)
      : _countStreamController =
            StreamController<int>().withCache(initialCount);

  /// Streamバージョン
  final CacheValueStreamController<int> _countStreamController;

  Stream<int> get countStream => _countStreamController.stream;

  int get currentCount => _countStreamController.currentValue;

  /// Stream用のカウントインクリメント
  void incrementCountOnStream() {
    _countStreamController.add(currentCount + 1);
  }

  /// Provider用のカウントインクリメント
  void incrementCountOnProvider(WidgetRef ref) {
    final int currentCount = ref.read(counterProvider);
    ref.read(counterProvider.notifier).state = currentCount + 1;
  }

  Stream<List<BookEntity>> allBookWatchStream() =>
      WatchAllBookUseCase(locator().get<BookDbRepository>()).call();

  @override
  void dispose() {
    _countStreamController.close();
  }
}

const int _initialCount = 0;

final StateProvider<int> counterProvider =
    StateProvider((ref) => _initialCount);

/// ホーム画面となるページ
class HomePage extends BasePage<HomePageExtra, HomePageController> {
  const HomePage({Key? key, required HomePageExtra extra})
      : super(key: key, extra: extra);

  @override
  HomePageController createController(BuildContext context) {
    return HomePageController(_initialCount);
  }

  @override
  Widget buildPage(BuildContext context, HomePageController controller) {
    final appTheme = AppTheme.of(context);
    final appL10n = AppL10n.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: null,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: appL10n.appName,
              );
            },
          ),
        ],
        title: Text(appL10n.appName),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 横幅いっぱいを保つためにあらかじめ横幅をMAXに指定しておく
          const SizedBox(width: PaddingConst.auto),

          const SizedBox(height: PaddingConst.middle),
          const Text(
            ':STREAM VERSION:',
          ),
          const Text(
            'You have pushed the button this many times:',
          ),
          StreamBuilder<int>(
            initialData: controller.currentCount,
            stream: controller.countStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                logger().error(snapshot.error, {
                  'current_count': controller.currentCount,
                  'controller': controller
                });
                return Text(
                  '-',
                  style: appTheme.basic.textTheme.headlineMedium,
                );
              }

              final int count =
                  snapshot.hasData ? snapshot.data! : _initialCount;
              return Text(
                '$count',
                style: appTheme.basic.textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: PaddingConst.middle),
          const Text(
            ':PROVIDER VERSION:',
          ),
          const Text(
            'You have pushed the button this many times:',
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final int count = ref.watch(counterProvider);
              return Text(
                '$count',
                style: appTheme.basic.textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: PaddingConst.large),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final ThemeMode appThemeMode =
                  ref.watch(appThemeModeStateProvider);

              return DropdownButton<ThemeMode>(
                value: appThemeMode,
                items: [
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.light,
                    child: Text(ThemeMode.light.toString()),
                  ),
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.dark,
                    child: Text(ThemeMode.dark.toString()),
                  ),
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.system,
                    child: Text(ThemeMode.system.toString()),
                  )
                ],
                onChanged: (ThemeMode? value) {
                  ref
                      .read(appThemeModeStateProvider.notifier)
                      .setThemeMode(value);
                },
              );
            },
          ),
          OutlinedButton(
            onPressed: () {
              router().push(
                context,
                ErrorPageExtra(error: Exception('Dummy Error from Home')),
              );
            },
            child: const Text('Open This Home Page'),
          ),
          const SizedBox(height: PaddingConst.middle),
          StreamBuilder<List<BookEntity>>(
            stream: controller.allBookWatchStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: Container(
                    color: Colors.grey,
                    padding: const EdgeInsets.all(PaddingConst.middle),
                    child: ListView(
                      children: snapshot.data!.map((e) {
                        return Card(
                          child: Text(e.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                showDialog<dynamic>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('ERROR'),
                      content: Text(snapshot.error.toString()),
                    );
                  },
                );
                return Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.all(PaddingConst.middle),
                );
              }

              return Container(
                color: Colors.grey,
                padding: const EdgeInsets.all(PaddingConst.middle),
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: controller.incrementCountOnStream,
            child: Text(
              'S +1',
              style: appTheme.basic.textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: PaddingConst.middle),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () => controller.incrementCountOnProvider(ref),
                child: Text(
                  'P +1',
                  style: appTheme.basic.textTheme.labelLarge,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
