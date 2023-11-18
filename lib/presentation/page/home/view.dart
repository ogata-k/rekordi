import 'package:flutter/material.dart';
import 'package:rekordi/domain/component/locator.dart';
import 'package:rekordi/domain/component/logger.dart';
import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/domain/repository/file/preferences.dart';
import 'package:rekordi/presentation/page/error/view.dart';
import 'package:rekordi/presentation/page/home/controller.dart';
import 'package:rekordi/presentation/page/home/model.dart';
import 'package:rekordi/presentation/page/view.dart';
import 'package:rekordi/presentation/resource/l10n/l10n.dart';
import 'package:rekordi/presentation/resource/theme/const/padding.dart';
import 'package:rekordi/presentation/resource/theme/theme.dart';
import 'package:rekordi/presentation/usecase/theme/get_theme_mode.dart';

// @todo 実際のページ

class HomePageExtra extends IPageExtra {
  const HomePageExtra({required this.pageTitle}) : super();

  factory HomePageExtra.defaultExtra() => const HomePageExtra(pageTitle: null);

  final String? pageTitle;

  static const routingPath = '/home';

  @override
  String get absolutePagePath => '/home';
}

/// ホーム画面となるページ
class HomePage extends IPage<HomePageExtra, HomePageModel, HomePageController> {
  const HomePage({super.key, required super.extra});

  @override
  HomePageController createController(BuildContext context) {
    final PreferencesRepository preferences =
        locator().get<PreferencesRepository>();

    final model = HomePageModel(
      count: 0,
      themeMode: GetThemeModeUsecase(preferences).call(),
    );

    return HomePageController(
      model,
      preferences: preferences,
    );
  }

  @override
  Widget buildPage(BuildContext context, Widget? child) {
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
        title: Text(extra.pageTitle ?? appL10n.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Consumer<HomePageModel>(
              builder: (context, model, child) {
                return Text(
                  '${model.count}',
                  style: appTheme.data.textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: PaddingConst.large),
            Consumer<HomePageModel>(
              builder:
                  (BuildContext context, HomePageModel value, Widget? child) {
                return DropdownButton<ThemeMode>(
                  value: value.themeMode,
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
                    ),
                  ],
                  onChanged: (ThemeMode? value) {
                    getController(context)
                        .updateThemeMode(value)
                        .catchError((dynamic e, StackTrace stack) {
                      logger().info(e.toString(), {}, e, stack);
                    });
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
              child: const Text('Open Error Page'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                router().push(context, const HomePageExtra(pageTitle: 'PUSH'));
              },
              child: const Text('push'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                router().go(context, const HomePageExtra(pageTitle: 'GO'));
              },
              child: const Text('go'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                router().pushReplacement(
                  context,
                  const HomePageExtra(pageTitle: 'REPLACEMENT'),
                );
              },
              child: const Text('replacement'),
            ),
            // dummy space
            const SizedBox(height: 1000),
            const Text('End: Home Page'),
          ],
        ),
      ),
      floatingActionButton: FilledButton(
        onPressed: getController(context).increment,
        child: const Text('+1'),
      ),
    );
  }
}
