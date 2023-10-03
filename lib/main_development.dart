import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'global/api_client/base_url_pod.dart';
import 'app.dart';
import 'src/core/locale_storage/app_storage_pod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final appBox = await Hive.openBox('appBox');
  runApp(
    ProviderScope(
      overrides: [
        baseUrlProvider.overrideWith((ref) => "http://3.27.90.34:8000/"),
        appBoxProvider.overrideWithValue(appBox),
      ],
      child: DevicePreview(
        enabled: true,
        tools: const [
          ...DevicePreview.defaultTools,
        ],
        builder: (context) => const App(),
      ),
    ),
  );
}
