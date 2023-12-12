import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/notifiers/cart_notifier.dart';
import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';
import 'package:hive/hive.dart';

/// This provider used for Storing Hive Box which you can override on
/// bootstrap function on start of the app
final cartBoxProvider = Provider.autoDispose<Box>(
  (ref) => throw UnimplementedError("appBoxProvider is not overriden"),
  name: 'cartBoxProvider',
);

/// cart notifier
final cartItemProvide =
    AutoDisposeNotifierProvider<CartNotifier, List<CartItem>>(
  () => CartNotifier(),
  name: "cartItemProvide",
);
