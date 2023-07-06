import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rekordi/presentation/data_model/app_theme_mode.dart';
import 'package:rekordi/presentation/resource/theme.dart';
import 'package:rekordi/presentation/usecase/for_app/initialize_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeAppUsecase().call(minimize: false);

  runApp(const ProviderScope(child: RekordiApp()));
}

class RekordiApp extends ConsumerWidget {
  const RekordiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeBuilder themeBuilder = ThemeBuilder.appDefault();
    final ThemeMode appThemeMode = ref.watch(appThemeModeStateProvider);

    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: themeBuilder.buildLight(),
      darkTheme: themeBuilder.buildDark(),
      themeMode: appThemeMode,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        automaticallyImplyLeading: false,
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
