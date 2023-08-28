import 'package:auto_route/auto_route.dart';
import 'app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  late final List<AutoRoute> routes = [
    AutoRoute(
        page: HomeRoute.page,
        path: '/homeRoute',
        initial: true,
        children: [
          AutoRoute(
            page: DashboardRoute.page,
            path: 'dashboardRoute',
          ),
          AutoRoute(page: HistoryRoute.page, path: 'historyRoute', children: [
            AutoRoute(
              page: HistoryDetailsRoute.page,
              path: 'historyRoute/historyDetailsRoute',
            )
          ]),
          AutoRoute(
            page: SettingsRoute.page,
            path: 'settingsRoute',
          ),
        ]),
  ];
}
