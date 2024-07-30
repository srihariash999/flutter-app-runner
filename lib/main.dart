import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Controllers/actions_provider.dart';
import 'package:flutter_runner_ui/Controllers/home_provider.dart';
import 'package:flutter_runner_ui/Screens/home_screen.dart';
import 'package:flutter_runner_ui/Utils/hive_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:provider/provider.dart';

void main() async {
// This is our global ServiceLocator

  GetIt.instance.registerSingleton(HiveHelper());
  GetIt.instance.registerSingleton<HomeProvider>(HomeProvider());
  GetIt.instance.registerSingleton<ActionsProvider>(ActionsProvider());

  await Hive.initFlutter();
  // dart widget ensure initilized

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.instance.get<HomeProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetIt.instance.get<ActionsProvider>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosTheme(
      data: MacosThemeData(
        brightness: Brightness.light,
      ),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
