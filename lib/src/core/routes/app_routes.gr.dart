// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:foodibizz/src/features/cart/screen/cart_recipes_screen.dart'
    deferred as _i3;
import 'package:foodibizz/src/features/dashboard/screen/add_update_recipe_screen.dart'
    deferred as _i1;
import 'package:foodibizz/src/features/dashboard/screen/dashboard_screen.dart'
    deferred as _i4;
import 'package:foodibizz/src/features/dashboard/screen/dashboard_tab.dart'
    deferred as _i5;
import 'package:foodibizz/src/features/dashboard/screen/file_picker_bottomsheet.dart'
    deferred as _i6;
import 'package:foodibizz/src/features/history/screen/all_orders_screen.dart'
    deferred as _i2;
import 'package:foodibizz/src/features/history/screen/history_screen.dart'
    deferred as _i7;
import 'package:foodibizz/src/features/history/screen/order_details_screen.dart'
    deferred as _i9;
import 'package:foodibizz/src/features/home/home_screen.dart' deferred as _i8;
import 'package:foodibizz/src/features/setting/setting_screen.dart'
    deferred as _i10;
import 'package:foodibizz/src/features/splash/splash_screen.dart'
    deferred as _i11;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    AddUpdateRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.AddUpdateRecipeScreen(),
        ),
      );
    },
    AllOrdersRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.AllOrdersScreen(),
        ),
      );
    },
    CartRecipesRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.CartRecipesScreen(),
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.DashboardScreen(),
        ),
      );
    },
    DashboardTabRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.DashboardTab(),
        ),
      );
    },
    FilePickerBottomSheetRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.FilePickerBottomSheet(),
        ),
      );
    },
    HistoryRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.HistoryScreen(),
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.HomeScreen(),
        ),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i9.loadLibrary,
          () => _i9.OrderDetailsScreen(),
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.SettingScreen(),
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.SplashScreen(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AddUpdateRecipeScreen]
class AddUpdateRoute extends _i12.PageRouteInfo<void> {
  const AddUpdateRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AddUpdateRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddUpdateRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AllOrdersScreen]
class AllOrdersRoute extends _i12.PageRouteInfo<void> {
  const AllOrdersRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AllOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllOrdersRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CartRecipesScreen]
class CartRecipesRoute extends _i12.PageRouteInfo<void> {
  const CartRecipesRoute({List<_i12.PageRouteInfo>? children})
      : super(
          CartRecipesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRecipesRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.DashboardScreen]
class DashboardRoute extends _i12.PageRouteInfo<void> {
  const DashboardRoute({List<_i12.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DashboardTab]
class DashboardTabRoute extends _i12.PageRouteInfo<void> {
  const DashboardTabRoute({List<_i12.PageRouteInfo>? children})
      : super(
          DashboardTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardTabRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.FilePickerBottomSheet]
class FilePickerBottomSheetRoute extends _i12.PageRouteInfo<void> {
  const FilePickerBottomSheetRoute({List<_i12.PageRouteInfo>? children})
      : super(
          FilePickerBottomSheetRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilePickerBottomSheetRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HistoryScreen]
class HistoryRoute extends _i12.PageRouteInfo<void> {
  const HistoryRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.OrderDetailsScreen]
class OrderDetailsRoute extends _i12.PageRouteInfo<void> {
  const OrderDetailsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          OrderDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SettingScreen]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SplashScreen]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}
