import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rekordi/app.dart';
import 'package:rekordi/presentation/usecase/for_app/initialize_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeAppUsecase().call(minimize: false);

  runApp(const ProviderScope(child: RekordiApp()));
}
