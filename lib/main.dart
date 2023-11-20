import 'package:flutter/material.dart';
import 'package:rekordi/presentation/page/app/view.dart';
import 'package:rekordi/presentation/usecase/init_app/initialize_app_async.dart';
import 'package:rekordi/presentation/usecase/init_app/initialize_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InitializeLocatorUsecase().call();
  await InitializeAppAsyncUsecase().call();

  // 今はデフォルト値を利用するので未指定だが、必要ならresponsive_builderをimportして下記を指定する。
  // ResponsiveSizingConfig.instance.setCustomBreakpoints()

  runApp(const RekordiApp());
}
