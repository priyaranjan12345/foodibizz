import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'global/api_client/base_url_pod.dart';
import 'app.dart';
import 'src/core/locale_storage/app_storage_pod.dart';
import 'src/features/dashboard/controller/providers/cart_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDisplayMode.setHighRefreshRate();
  final directory = await getApplicationCacheDirectory();
  await Hive.initFlutter(directory.path);
  final appBox = await Hive.openBox('appBox');
  final cartBox = await Hive.openBox('cartBox');

  runApp(
    ProviderScope(
      overrides: [
        baseUrlProvider.overrideWith((ref) => "http://3.27.90.34:8000/"),
        appBoxProvider.overrideWithValue(appBox),
        cartBoxProvider.overrideWithValue(cartBox),
      ],
      child: const App(),
    ),
  );
}
