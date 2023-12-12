import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';
import 'package:foodibizz/src/core/localization/locale_pod.dart';
import 'package:foodibizz/src/core/routes/auto_route_observer.dart';
import 'package:foodibizz/src/core/routes/router_pod.dart';
import 'package:foodibizz/src/core/theme/app_them_pod.dart';
import 'package:foodibizz/src/core/theme/app_themes.dart';
import 'package:foodibizz/src/core/utils/responsive_break_point_wrapper.dart';


class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final approuter = ref.watch(autorouterProvider);
    final currentTheme = ref.watch(themecontrollerProvider);
    final currentLocale = ref.watch(localePod);

    return MaterialApp.router(
      title: 'FoodiBizz',
      locale: currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: currentTheme,
      darkTheme: AppThemes.darkTheme,
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: approuter.config(
        navigatorObservers: () => [
          RouterObserver(),
        ],
      ),
      builder: (context, child) {
        child = DevicePreview.appBuilder(context, child);
        child = ResponsiveBreakPointWrapper(child: child);
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
    );
  }
}
