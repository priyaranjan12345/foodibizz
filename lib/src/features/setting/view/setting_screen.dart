import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/core/localization/locale_pod.dart';
import 'package:foodibizz/src/core/theme/app_them_pod.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';
import 'package:foodibizz/src/features/setting/view/widgets/theme_mode_switch.dart';

@RoutePage(deferredLoading: true, name: "SettingsRoute")
class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

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
                // showAboutDialog(context: context, );
                // context.navigateTo(AboutDialogRoute());
              },
            ),
            const Divider(),
            const SizedBox(height: 40),
            Text(
              "FoodiBizz",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
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
