import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Utils/constants.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  late final Box<String> box;

  HiveHelper() {
    _init();
  }

  void _init() async {
    // Get the box and store the ref int he box variable.
    box = await Hive.openBox<String>(kSettingsStorageBoxName);
  }

  /// Getter to get the repo link.
  ///
  /// returns `String` containing stored repo link if exists,
  ///
  /// return `null` if no repo link is stored.
  String? get getRepoLink => box.get(kAppRepoLinkKey);


  /// 
  Future<bool> setRepoLink(String link) async {
    try {
      await box.put(kAppRepoLinkKey, link);
      return true;
    } catch (e) {
      debugPrint("Cannot set repo link: $e");
      return false;
    }
  }

  // -- xx --
}
