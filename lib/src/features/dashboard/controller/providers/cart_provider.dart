import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../data/service/card_storage.dart';
import '../../model/cart_food_item_model.dart';

/// This provider used for App Storage Service class which
/// depends on appBoxProvider for getting intial Hive Box
final cartStorageProvider = Provider.autoDispose<CartStorage>(
  (ref) => CartStorage(ref.watch(cartBoxProvider)),
  name: 'cartStorageProvider',
);

/// This provider used for Storing Hive Box which you can override on
/// bootstrap function on start of the app
final cartBoxProvider = Provider.autoDispose<Box<CartFoodItemModel>>(
  (ref) => Hive.box<CartFoodItemModel>("cartBox"),
  name: 'cartBoxProvider',
);
