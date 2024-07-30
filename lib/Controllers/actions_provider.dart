import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Utils/hive_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:process_run/process_run.dart';

class ActionsProvider extends ChangeNotifier {
  final _hiveHelper = GetIt.instance<HiveHelper>();

  var loading = false;

  var gitBranches = <String>[];
  var availableDevices = <String>[];

  String? selectedDevice;
  String? selectedBranch;

  void populateGitBranchesAndDevices() async {
    loading = true;
    notifyListeners();

    // Get branches
    var branches = await getBranches();
    gitBranches = branches;

    // Get devices
    var devices = await getDevices();
    availableDevices = devices;

    if (availableDevices.isNotEmpty) {
      selectedDevice = availableDevices.first;
    }

    if (gitBranches.isNotEmpty) {
      var index = gitBranches.indexWhere((branch) => branch.contains('*'));
      if (index != -1) {
        gitBranches[index] = gitBranches[index].replaceAll('*', '');
        selectedBranch = gitBranches[index];
      } else {
        selectedBranch = gitBranches.first;
      }
    }

    loading = false;
    notifyListeners();
  }

  Future<List<String>> getBranches() async {
    var branches = await Process.run('git', ['branch'], runInShell: true);
    return branches.outLines.toList();
  }

  Future<List<String>> getDevices() async {
    var d = await Process.run('flutter', ['devices'], runInShell: true);
    RegExp deviceRegExp = RegExp(r'^\s*(.+?)\s*\(.*\)', multiLine: true);
    Iterable<RegExpMatch> matches = deviceRegExp.allMatches(d.outText);

    List<String> devices = [];
    for (var match in matches) {
      devices.add(match.group(1)?.trim() ?? '');
    }
    return devices;
  }

  // Run
  Future<void> run() async {
    var path = _hiveHelper.getRepoLink;

    print("path is $path");

    if (path == null || path.isEmpty) {
      print("No path found");
      return;
    }

    // cd into the path

    // print("changing directory to $path");
    // var cdRes = await Process.run('cd', [path], runInShell: true);
    // print("cdRes is ${cdRes.stdout}");

    print("running flutter run -d $selectedDevice");
    var res = await Process.run(
      'flutter',
      ['run', '--release', '-d', "$selectedDevice"],
      workingDirectory: path,
      runInShell: true,
    );

    print(" res is ${res.outText}");
  }
}
