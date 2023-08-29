import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';

@RoutePage(deferredLoading: true, name: "HomeRoute")
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AutoTabsScaffold(
      routes: const [
        DashboardRoute(),
        ItemsRoute(),
        HistoryRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        final tabsRouter = AutoTabsRouter.of(context);

        return NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: (int index) {
            tabsRouter.setActiveIndex(index);
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.dashboard),
              label: l10n.dashboard,
            ),
            NavigationDestination(
              icon: const Icon(Icons.list),
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
      },
    );
  }
}
