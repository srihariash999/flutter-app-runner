import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

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
  var flutterVersion = '';
  var gitVersion = '';

  var loading = false;

  var appState = AppState.initial;

  // Functions

  Future<void> computeState() async {
    appState = AppState.loading;
    notifyListeners();

    var depsCheck = await checkDependencies();

    if (!depsCheck) {
      appState = AppState.checkDevicesFailed;
      notifyListeners();
      return;
    }

    // Dependencies are checked. Moved to cloning repo step.

    


  }

  Future<bool> checkDependencies() async {
    try {
      var fCheck = await _checkFlutter();
      var gCheck = await _checkGit();

      if (fCheck == null || gCheck == null) {
        return false;
      } else {
        flutterVersion = fCheck;
        gitVersion = gCheck;
        return true;
      }
    } catch (e) {
      print(" Error getting deps: $e");
      return false;
    }
  }

  Future<String> _runCommandsInShell(String command) async {
    var shell = Shell();
    var res = await shell.run(command);
    return res.outText;
  }

  Future<String?> _checkFlutter() async {
    try {
      var res = await _runCommandsInShell('''flutter --version''');

      if (res.toLowerCase().contains('flutter')) {
        res = res
            .split('•')
            .first
            .toLowerCase()
            .replaceAll('flutter', '')
            .replaceAll(' ', '');

        if (res.isNotEmpty) return res;

        return null;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<String?> _checkGit() async {
    try {
      var res = await _runCommandsInShell('''git --version''');

      if (res.toLowerCase().contains('git')) {
        res = res
            .toLowerCase()
            .replaceAll('git', '')
            .replaceAll('version', '')
            .replaceAll(' ', '');

        if (res.isNotEmpty) return gitVersion;

        return null;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> cloneRepo() async {
    await _runCommandsInShell(
        'git clone https://github.com/zed-industries/zed.git');
  }
}
