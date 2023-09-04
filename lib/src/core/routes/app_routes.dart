import 'package:auto_route/auto_route.dart';
import 'app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  late final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page, path: '/', initial: true, children: [
      AutoRoute(
        page: DashboardRoute.page,
        path: 'dashboardRoute',
        initial: true,
      ),
      AutoRoute(page: HistoryRoute.page, path: 'historyRoute', children: [
        AutoRoute(
          page: AllOrdersRoute.page,
          path: 'allOrdersRoute',
          initial: true,
        ),
        AutoRoute(
          page: OrderDetailsRoute.page,
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
