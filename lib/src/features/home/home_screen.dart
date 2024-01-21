import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';

@RoutePage(deferredLoading: true, name: "HomeRoute")
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime backPressTime = DateTime.now();
  List<int> history = [];

  // bool _onWillPop(TabsRouter tabsRouter) {
  //   if (history.isNotEmpty) {
  //     tabsRouter.setActiveIndex(history.last);
  //     history.removeLast();
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  bool _onWillPop(TabsRouter tabsRouter) {
    if (history.isNotEmpty) {
      tabsRouter.setActiveIndex(history.last);
      history.removeLast();
      return false;
    }

    final difference = DateTime.now().difference(backPressTime);
    backPressTime = DateTime.now();

    if (difference >= const Duration(seconds: 2)) {
      Fluttertoast.showToast(msg: "Press again to close the app");
      return false;
    }

    SystemNavigator.pop(animated: true);
    return true;
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
          canPop: false,
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
