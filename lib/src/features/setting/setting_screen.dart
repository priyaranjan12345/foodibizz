import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/core/localization/locale_pod.dart';
import 'package:foodibizz/src/core/theme/app_them_pod.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.watch(themecontrollerProvider);
    final l10n = context.l10n;
    return Scaffold(
        appBar: AppBar(
          title: const Text("FoodiBizz"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              ListTile(
                  title: Text(l10n.dark),
                  trailing: Switch(
                      value: themeController == ThemeMode.dark,
                      onChanged: (value) {
                        final newTheme =
                            value ? ThemeMode.dark : ThemeMode.light;
                        ref
                            .read(themecontrollerProvider.notifier)
                            .changeTheme(theme: newTheme);
                      })),
              ListTile(
                  title: Text(l10n.language),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      ref
                          .read(localePod.notifier)
                          .changeLocale(locale: Locale(value));
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'en',
                        child: Text(l10n.english),
                      ),
                      PopupMenuItem<String>(
                        value: 'hi',
                        child: Text(l10n.hindi),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}