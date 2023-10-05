import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartStorage {
  Box appBox;

  CartStorage(this.appBox);

  /// for getting value as String for a
  /// given key from the box
  List<CartFoodItemModel> get({required String key}) {
    final data = appBox.get(key) as List<CartFoodItemModel>?;
    return data ?? <CartFoodItemModel>[];
  }

  /// for storing value on defined key
  /// on the box
  Future<void> put({
    required String key,
    required List<CartFoodItemModel> values,
  }) async {
    await appBox.put(key, values);
  }

  /// for clearing all data in box
  Future<void> clearAllData() async {
    await appBox.clear();
  }

  void close() {
    Hive.box("cartBox").close();
  }
}
