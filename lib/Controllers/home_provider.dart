import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Controllers/deps_checker_provider.dart';
import 'package:flutter_runner_ui/Utils/hive_helper.dart';
import 'package:get_it/get_it.dart';

enum AppState {
  initial,
  loading,
  dependenciesCheck,
  dependenciesCheckFailed,
  repositorySetup,
  repositorySetupFailed,
  checkDevices,
  checkDevicesFailed,
}

class HomeProvider extends ChangeNotifier {
  // Variables
  String? flutterVersion;
  String? gitVersion;
  String? repoPath;

  var appState = AppState.initial;

  var depsCheckController = DependenciesCheckerProvider();

  final _hiveHelper = GetIt.instance<HiveHelper>();

  // Functions
  Future<void> initiateDepsCheck() async {
    await _hiveHelper.init();

    // Set state to loading
    appState = AppState.loading;
    notifyListeners();

    // Initiate dependencies check
    var (fVer, gVer) = await depsCheckController.checkDependencies();

    flutterVersion = fVer;
    gitVersion = gVer;

    // If dependencies check failed, set state to dependencies check failed
    if (fVer == null || gVer == null) {
      appState = AppState.dependenciesCheckFailed;
      notifyListeners();
      return;
    }

    appState = AppState.repositorySetup;
    notifyListeners();

    // Initiate repository setup
    initiateRepoSetup();
  }

  Future<void> initiateRepoSetup() async {
    // Get saved repo link
    var savedRepoLink = _hiveHelper.getRepoLink;

    // If no repo link is saved, set state to repository setup
    if (savedRepoLink == null) {
      appState = AppState.repositorySetup;
      notifyListeners();
      return;
    }

    repoPath = savedRepoLink;

    appState = AppState.checkDevices;
    notifyListeners();
  }

  void selectRepo() async {
    // Pick a repository directory
    var res = await FilePicker.platform
        .getDirectoryPath(dialogTitle: "Select Repository");

    // If no directory is selected, return
    if (res == null) return;

    var parts = res.split("/");

    var userPart =
        parts.firstWhere((element) => element.toLowerCase().contains("users"));

    parts = parts.sublist(parts.indexOf(userPart) + 2);
    parts = parts.map((element) => element.replaceAll(" ", '\\ ')).toList();
    var path = parts.join("/");

    // Save the selected directory to local storage
    var saveRes = await _hiveHelper.setRepoLink(path);

    if (saveRes == false) return;

    repoPath = path;

    // Set state to check devices
    appState = AppState.checkDevices;
    notifyListeners();
  }
  //
}
