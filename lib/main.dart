import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Controllers/home_provider.dart';
import 'package:flutter_runner_ui/Screens/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
// This is our global ServiceLocator
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<HomeProvider>(HomeProvider());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt.get<HomeProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
