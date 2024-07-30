import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:process_run/process_run.dart';

Future<String> runCommandsInShell(String command) async {
  var shell = Shell();
  var res = await shell.run(command);
  return res.outText;
}

// Font applicator extension on TextStyle using google fonts
extension DefaultFontTextStyle on TextStyle {
  TextStyle get withDefaultFont {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
