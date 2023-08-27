import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/core/locale_storage/app_storage_pod.dart';
import 'package:foodibizz/src/core/localization/locale_pod.dart';
import 'package:foodibizz/src/core/theme/app_them_pod.dart';
import 'package:foodibizz/src/core/theme/app_themes.dart';
import 'package:foodibizz/src/features/home/home_screen.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final appBox = await Hive.openBox('appBox');
  runApp(ProviderScope(
      overrides: [appBoxProvider.overrideWithValue(appBox)],
      child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themecontrollerProvider);
    final currentLocale = ref.watch(localePod);
    return MaterialApp(
      title: 'Electronic Store',
      locale: currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: currentTheme,
      darkTheme: AppThemes.darkTheme,
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
