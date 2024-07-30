import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Controllers/home_provider.dart';
import 'package:flutter_runner_ui/Screens/initial_screen.dart';
import 'package:flutter_runner_ui/Screens/repository_setup.dart';
import 'package:flutter_runner_ui/Screens/setup_devices.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeProvider = GetIt.instance.get<HomeProvider>();

  @override
  void initState() {
    super.initState();
    // homeProvider.initiateDepsCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<HomeProvider>(
        builder: (context, model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(" ${model.appState} "),
              // If loading, show loader.
              if (model.appState == AppState.loading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

              // If initial, show initial screen.
              if (model.appState == AppState.initial)
                const Expanded(child: InitialScreenState()),

              // If dependencies check is in progress, show text.
              if (model.appState == AppState.repositorySetup)
                const Expanded(child: RepoSetupScreen()),

              // If devices setup is in progress, show text.
              if (model.appState == AppState.checkDevices)
                const Expanded(child: SetupDevices()),
            ],
          );
        },
      ),
    );
  }
}
