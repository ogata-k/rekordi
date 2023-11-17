import 'package:flutter/material.dart';
import 'package:rekordi/app.dart';
import 'package:rekordi/presentation/usecase/init_app/initialize_app_async.dart';
import 'package:rekordi/presentation/usecase/init_app/initialize_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InitializeLocatorUsecase().call();
  await InitializeAppAsyncUsecase().call();

  runApp(const RekordiApp());
}
