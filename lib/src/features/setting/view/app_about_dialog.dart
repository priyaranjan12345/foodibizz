import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(deferredLoading: true, name: "AboutDialogRoute")
class AppAboutDialog extends StatelessWidget {
  const AppAboutDialog({
    super.key,
    this.appName = "FoodiBizz",
    this.appVersion = '1.0',
    this.appIcon = const Icon(
      Icons.local_florist_outlined,
      size: 50,
    ),
    this.appAuther = '© 2023 Images by Priyaranjan Mantri',
  });

  final String appName;
  final String appVersion;
  final Icon appIcon;
  final String appAuther;

  @override
  Widget build(BuildContext context) {
    return AboutDialog(
      applicationName: appName,
      applicationVersion: appVersion,
      applicationIcon: appIcon,
      applicationLegalese: appAuther,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  text:
                      'FoodiBizz empowers users to efficiently track order details, '
                      'streamlining their operations for rapid business growth while seamlessly generating bills',
                ),
                TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  text: '.\n\n',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
