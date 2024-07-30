import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Controllers/actions_provider.dart';
import 'package:flutter_runner_ui/Screens/info_container.dart';
import 'package:get_it/get_it.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:provider/provider.dart';

class SetupDevices extends StatefulWidget {
  const SetupDevices({super.key});

  @override
  State<SetupDevices> createState() => _SetupDevicesState();
}

class _SetupDevicesState extends State<SetupDevices> {
  final actionsProvider = GetIt.instance.get<ActionsProvider>();

  @override
  void initState() {
    actionsProvider.populateGitBranchesAndDevices();
    super.initState();
  }

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
          Consumer<ActionsProvider>(
            builder: (context, actionsProvider, child) {
              if (actionsProvider.loading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Devices Dropdown
                        DropdownButton<String>(
                          value: actionsProvider.selectedDevice,
                          items: actionsProvider.availableDevices
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            actionsProvider.selectedDevice = value;
                            setState(() {});
                          },
                        ),

                        // Branches Dropdown
                        DropdownButton<String>(
                          value: actionsProvider.selectedBranch,
                          items: actionsProvider.gitBranches
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            actionsProvider.selectedBranch = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    PushButton(
                      controlSize: ControlSize.regular,
                      onPressed: () async {
                        actionsProvider.run();
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: const Center(
                          child: Text(
                            'Run',
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
            },
          ),
        ],
      ),
    );
  }
}
