import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'global/api_client/base_url_pod.dart';
import 'app.dart';
import 'src/core/locale_storage/app_storage_pod.dart';
import 'src/features/dashboard/model/cart_food_item_model.dart';
import 'src/features/dashboard/controller/providers/cart_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartFoodItemModelAdapter());
  final appBox = await Hive.openBox('appBox');
  final cartBox = await Hive.openBox<List<CartFoodItemModel>>('cartBox');

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