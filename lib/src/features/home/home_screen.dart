import 'package:flutter/material.dart';
import 'package:foodibizz/src/features/home/controller/home_provider.dart';
import 'package:foodibizz/src/features/setting/setting_screen.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: navigationbarCurrentIndex,
          builder: (context, _, __) {
            return NavigationBar(
              elevation: 5.0,
              labelBehavior: labelBehavior,
              selectedIndex: navigationbarCurrentIndex.value,
              onDestinationSelected: (int index) {
                navigationbarCurrentIndex.value = index;
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.dashboard),
                  label: l10n.dashboard,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.shopping_cart),
                  label: l10n.items,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.history),
                  label: l10n.history,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings),
                  label: l10n.setting,
                ),
              ],
            );
          }),
      body: _screens[navigationbarCurrentIndex.value],
    );
  }

  final List<Widget> _screens = [
    const SettingScreen(),
    const SettingScreen(),
    const SettingScreen(),
    const SettingScreen()
  ];
}
