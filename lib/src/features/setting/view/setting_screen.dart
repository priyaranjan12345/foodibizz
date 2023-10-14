import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/locale_pod.dart';
import '../../../core/theme/app_them_pod.dart';
import '../../../core/localization/l10n.dart';
import '../../../features/setting/view/widgets/theme_mode_switch.dart';

@RoutePage(deferredLoading: true, name: "SettingsRoute")
class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  void showAppAboutDialog(
    BuildContext context, {
    String appName = "FoodiBizz",
    String appVersion = '1.0',
    Icon appIcon = const Icon(
      Icons.local_florist_outlined,
      size: 50,
    ),
    String appAuther = '© 2023 Images by Priyaranjan Mantri',
  }) {
    showAboutDialog(
      context: context,
      applicationName: appName,
      applicationVersion: appVersion,
      applicationIcon: appIcon,
      applicationLegalese: appAuther,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: RichText(
            textAlign: TextAlign.left,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.watch(themecontrollerProvider);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.setting),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode_outlined),
              title: Text(l10n.dark),
              trailing: ThemeModeSwitch(
                themeMode: themeController,
                onChanged: (value) {
                  ref
                      .read(themecontrollerProvider.notifier)
                      .changeTheme(theme: value);
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.translate),
              title: Text(l10n.language),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  ref.read(localePod.notifier).changeLocale(
                        locale: Locale(value),
                      );
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'en',
                    child: Text(l10n.english),
                  ),
                  PopupMenuItem<String>(
                    value: 'hi',
                    child: Text(l10n.hindi),
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.support_agent),
              title: Text("Help and support"),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                showAppAboutDialog(context);
              },
            ),
            const Divider(),
            const SizedBox(height: 40),
            Image.asset(
              "assets/app-icon.png",
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 10),
            Text(
              "FoodiBizz",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Version 1.0",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
