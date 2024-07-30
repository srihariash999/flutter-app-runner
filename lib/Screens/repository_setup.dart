import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Controllers/home_provider.dart';
import 'package:flutter_runner_ui/Screens/info_container.dart';
import 'package:flutter_runner_ui/Utils/helpers.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:provider/provider.dart';

class RepoSetupScreen extends StatelessWidget {
  const RepoSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        children: [
          const InfoContainer(),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PushButton(
                controlSize: ControlSize.regular,
                onPressed: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .selectRepo();
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Center(
                    child: Text(
                      'Choose Repository',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ).withDefaultFont,
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
