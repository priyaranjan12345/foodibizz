import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';

@RoutePage(deferredLoading: true, name: "HomeRoute")
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///add here
  List<int> history = [];
  Future<bool> _onWillPop(TabsRouter tabsRouter) async {
    //modify
    if (history.isNotEmpty) {
      tabsRouter.setActiveIndex(history.last);
      history.removeLast();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AutoTabsRouter.pageView(
    physics: const NeverScrollableScrollPhysics(),
      routes: const [
        DashboardRoute(),
        HistoryRoute(),
        SettingsRoute(),
      ],
      builder: (ctx, child, pageController) {
        final tabsRouter = AutoTabsRouter.of(ctx);
        return PopScope(
          onPopInvoked: (v) => _onWillPop(tabsRouter),
          child: Scaffold(
            body: child,
            bottomNavigationBar: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              selectedIndex: tabsRouter.activeIndex,
              onDestinationSelected: (int index) {
                history.add(tabsRouter.activeIndex);
                tabsRouter.setActiveIndex(index);
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.dashboard_outlined),
                  label: l10n.dashboard,
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
            ),
          ),
        );
      },
    );
  }
}
