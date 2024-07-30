import 'package:flutter/material.dart';
import 'package:flutter_runner_ui/Controllers/home_provider.dart';
import 'package:flutter_runner_ui/Utils/helpers.dart';
import 'package:provider/provider.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (homeProvider.flutterVersion != null)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Flutter Version: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ).withDefaultFont,
                  ),
                  TextSpan(
                    text: "${homeProvider.flutterVersion}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                    ).withDefaultFont,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          if (homeProvider.gitVersion != null)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Git Version: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ).withDefaultFont,
                  ),
                  TextSpan(
                    text: "${homeProvider.gitVersion}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                    ).withDefaultFont,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          if (homeProvider.repoPath != null)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Chosen Repository: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ).withDefaultFont,
                  ),
                  TextSpan(
                    text: "${homeProvider.repoPath}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                    ).withDefaultFont,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
