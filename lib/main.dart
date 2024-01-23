import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/app.dart';
import 'package:foodibizz/global/api_client/base_url_pod.dart';
import 'package:foodibizz/global/helper/app_talker.dart';
import 'package:foodibizz/global/riverpod_ext/riverpod_observer.dart';
import 'package:foodibizz/src/core/locale_storage/app_storage_pod.dart';
import 'package:foodibizz/src/features/dashboard/controller/providers/cart_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await FlutterDisplayMode.setHighRefreshRate();
  final directory = await getApplicationCacheDirectory();
  await Hive.initFlutter(directory.path);
  final appBox = await Hive.openBox('appBox');
  final cartBox = await Hive.openBox('cartBox');

  runApp(
    ProviderScope(
      overrides: [
        baseUrlProvider.overrideWith((ref) => 'http://3.27.90.34:8000/'),
        appBoxProvider.overrideWithValue(appBox),
        cartBoxProvider.overrideWithValue(cartBox),
      ],
      observers: [RiverpodObserverLogger(talker: talker)],
      child: const FoodibizzApp(),
    ),
  );
}
