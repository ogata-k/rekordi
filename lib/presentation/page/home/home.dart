import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rekordi/component/locator.dart';
import 'package:rekordi/component/router.dart';
import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/book.dart';
import 'package:rekordi/presentation/model/app_theme_mode.dart';
import 'package:rekordi/presentation/page/base.dart';
import 'package:rekordi/presentation/page/error/error.dart';
import 'package:rekordi/presentation/resource/l10n/l10n.dart';
import 'package:rekordi/presentation/usecase/book/watch_all.dart';

// @todo 実際のページ

class HomePageExtra extends BasePageExtra {
  const HomePageExtra() : super();

  factory HomePageExtra.defaultExtra() => const HomePageExtra();

  static const routingPath = '/home';

  @override
  String get absolutePagePath => '/home';
}

/// ホーム画面となるページ
class HomePage extends BasePage<HomePageExtra> {
  const HomePage({Key? key, required HomePageExtra extra})
      : super(key: key, extra: extra);

  @override
  Widget build(BuildContext context) {
    return _HomePage(key: key);
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                applicationName: L10n.of(context).appName,
              );
            },
          ),
        ],
        title: Text(L10n.of(context).appName),
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //
        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 16),
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              color: Colors.grey,
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<List<BookEntity>>(
                stream: WatchAllUseCase(locator().get<BookRepository>()).call(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.map((e) {
                        return Card(
                          child: Text(e.toString()),
                        );
                      }).toList(),
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
                    return Container();
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
