import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Utils/constants.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  Box<String>? box;

  // HiveHelper() {
  //   print("constructor is called");
  // }

  Future<void> init() async {
    // Get the box and store the ref int he box variable.
    box = await Hive.openBox<String>(kSettingsStorageBoxName);
    print("Hive helper is initialized");
  }

  /// Getter to get the repo link.
  ///
  /// returns `String` containing stored repo link if exists,
  ///
  /// return `null` if no repo link is stored.
  String? get getRepoLink => box?.get(kAppRepoLinkKey);

  /// Method to save the repo link to local storage.
  ///
  /// returns `true` if the repo link is saved successfully,
  ///
  /// returns `false` if the repo link could not be saved.
  Future<bool> setRepoLink(String link) async {
    try {
      await box?.put(kAppRepoLinkKey, link);
      return true;
    } catch (e) {
      debugPrint("Cannot set repo link: $e");
      return false;
    }
  }

  Future<bool> clearSavedRepo() async {
    try {
      await box?.delete(kAppRepoLinkKey);
      return true;
    } catch (e) {
      debugPrint("Cannot clear saved repo link: $e");
      return false;
    }
  }

  // -- xx --
}
