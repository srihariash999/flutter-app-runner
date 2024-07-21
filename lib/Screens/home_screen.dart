import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Controllers/home_provider.dart';
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
    homeProvider.checkDependencies();
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
              Text("Flutter Version: ${model.flutterVersion}"),
              Text("Git Version: ${model.gitVersion}"),
            ],
          );
        },
      ),
    );
  }
}
