import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'global/api_client/base_url_pod.dart';
import 'src/core/locale_storage/app_storage_pod.dart';
import 'src/core/localization/locale_pod.dart';
import 'src/core/routes/auto_route_observer.dart';
import 'src/core/routes/router_pod.dart';
import 'src/core/theme/app_them_pod.dart';
import 'src/core/theme/app_themes.dart';
import 'src/core/localization/l10n.dart';
import 'src/core/utils/responsive_break_point_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final appBox = await Hive.openBox('appBox');
  runApp(
    ProviderScope(
      overrides: [
        baseUrlProvider.overrideWith((ref) => "my base url"),
        appBoxProvider.overrideWithValue(appBox),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

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
        child = ResponsiveBreakPointWrapper(child: child!);
        return child;
      },
    );
  }
}
