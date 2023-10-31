import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/presentation/model/app_theme_mode.dart';
import 'package:rekordi/presentation/page/base.dart';
import 'package:rekordi/presentation/page/error/error.dart';
import 'package:rekordi/presentation/resource/l10n/l10n.dart';
import 'package:rekordi/presentation/resource/theme/const/padding.dart';
import 'package:rekordi/presentation/resource/theme/theme.dart';
import 'package:rekordi/presentation/widget/listening.dart';

// @todo 実際のページ

class HomePageExtra extends BasePageExtra {
  const HomePageExtra() : super();

  factory HomePageExtra.defaultExtra() => const HomePageExtra();

  static const routingPath = '/home';

  @override
  String get absolutePagePath => '/home';
}

class HomePageModel extends BasePageModel with ChangeNotifier {
  HomePageModel(int initialCount) : _count = initialCount;

  int _count;

  int get currentCount => _count;

  void increment() {
    _count += 1;
    notifyListeners();
  }
}

class HomePageController extends BasePageController<HomePageModel> {
  const HomePageController(HomePageModel model) : super(model);

  @override
  void start(BuildContext context) {
    // none
  }

  @override
  void dispose() {
    // none
  }

  void incrementCount() => model.increment();
}

const int _initialCount = 0;

/// ホーム画面となるページ
class HomePage
    extends BasePage<HomePageExtra, HomePageModel, HomePageController> {
  const HomePage({Key? key, required HomePageExtra extra})
      : super(key: key, extra: extra);

  @override
  HomePageController createController(
    HomePageExtra extra,
  ) {
    final model = HomePageModel(_initialCount);
    return HomePageController(model);
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
            ':MVC VERSION:',
          ),
          const Text(
            'You have pushed the button this many times:',
          ),
          ListeningWidget(
            listening: controller.model,
            builder: (context, listening, child) {
              return Text(
                '${listening.currentCount}',
                style: appTheme.basic.textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: PaddingConst.large),
          // @todo Consumerを排除したい。この実装ならEventBusに流して、流されたことを検知したら更新するでもうまくいくはず。
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
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: controller.incrementCount,
        child: Text(
          '+1',
          style: appTheme.basic.textTheme.labelLarge,
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // none
  }
}
