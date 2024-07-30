import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_runner_ui/Controllers/home_provider.dart';
import 'package:flutter_runner_ui/Utils/hive_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter_runner_ui/Utils/helpers.dart';

class InitialScreenState extends StatelessWidget {
  const InitialScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(24),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ).withDefaultFont,
                ),
                const SizedBox(height: 24),
                Text(
                  "Click continue to begin!",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ).withDefaultFont,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PushButton(
                  controlSize: ControlSize.regular,
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .initiateDepsCheck();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ).withDefaultFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          PushButton(
            controlSize: ControlSize.regular,
            onPressed: () async {
              final h = GetIt.instance<HiveHelper>();

              if (h.box == null) await h.init();

              h.clearSavedRepo();
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.06,
              child: const Center(
                child: Text(
                  'Delete Hive',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
