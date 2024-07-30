import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Utils/helpers.dart';

class DependenciesCheckerProvider {
  Future<(String? flutterVersion, String? gitVersion)>
      checkDependencies() async {
    try {
      var fCheck = await _checkFlutter();
      var gCheck = await _checkGit();

      return (fCheck, gCheck);
    } catch (e) {
      debugPrint(" Error getting deps: $e");
      return (null, null);
    }
  }

  Future<String?> _checkFlutter() async {
    try {
      var res = await runCommandsInShell('''flutter --version''');

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
      debugPrint(" Error getting flutter version: $e");
      return null;
    }
    return null;
  }

  Future<String?> _checkGit() async {
    try {
      var res = await runCommandsInShell('''git --version''');

      if (res.toLowerCase().contains('git')) {
        res = res
            .toLowerCase()
            .replaceAll('git', '')
            .replaceAll('version', '')
            .replaceAll(' ', '');

        if (res.isNotEmpty) return res;

        return null;
      }
    } catch (e) {
      debugPrint(" Error getting git version: $e");
      return null;
    }
    return null;
  }
}
