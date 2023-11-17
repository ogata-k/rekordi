import 'package:flutter/material.dart';
import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/presentation/page/error/view.dart';
import 'package:rekordi/presentation/page/home/controller.dart';
import 'package:rekordi/presentation/page/home/model.dart';
import 'package:rekordi/presentation/page/view.dart';
import 'package:rekordi/presentation/resource/l10n/l10n.dart';
import 'package:rekordi/presentation/resource/theme/const/padding.dart';
import 'package:rekordi/presentation/resource/theme/theme.dart';

// @todo 実際のページ

class HomePageExtra extends IPageExtra {
  const HomePageExtra() : super();

  factory HomePageExtra.defaultExtra() => const HomePageExtra();

  static const routingPath = '/home';

  @override
  String get absolutePagePath => '/home';
}

const int _initialCount = 0;

/// ホーム画面となるページ
class HomePage extends IPage<HomePageExtra, HomePageModel, HomePageController> {
  const HomePage({super.key, required super.extra});

  @override
  HomePageController createController(BuildContext context) {
    const model = HomePageModel(count: _initialCount);
    return HomePageController(model);
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
        title: Text(appL10n.appName),
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
            // TODO ThemeMode切り替えボタン
            OutlinedButton(
              onPressed: () {
                router().push(
                  context,
                  ErrorPageExtra(error: Exception('Dummy Error from Home')),
                );
              },
              child: const Text('Open This Home Page'),
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
