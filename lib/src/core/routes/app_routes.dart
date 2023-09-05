import 'package:auto_route/auto_route.dart';
import 'app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  late final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page, path: '/', initial: true, children: [
      AutoRoute(
          page: DashboardTabRoute.page,
          path: 'dashboardTabRoute',
          initial: true,
          children: [
            AutoRoute(
              page: DashboardRoute.page,
              path: 'dashboardRoute',
              initial: true,
            ),
            AutoRoute(page: AddUpdateRoute.page, path: 'addUpdateRoute')
          ]),
      AutoRoute(page: HistoryRoute.page, path: 'historyRoute', children: [
        AutoRoute(
          page: AllOrdersRoute.page,
          path: 'allOrdersRoute',
          initial: true,
        ),
        AutoRoute(
          page: OrderDetailsRoute.page,
          path: 'orderDetailsRoute',
        )
      ]),
      AutoRoute(
        page: SettingsRoute.page,
        path: 'settingsRoute',
      ),
    ]),
  ];
}
