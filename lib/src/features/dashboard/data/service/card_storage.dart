import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartStorage {
  Box appBox;

  CartStorage(this.appBox);

  /// for getting value as String for a
  /// given key from the box
  List<CartFoodItemModel>? get({required String key}) {
    return appBox.get(key) as List<CartFoodItemModel>?;
  }

  /// for storing value on defined key
  /// on the box
  Future<void> put({
    required String key,
    required CartFoodItemModel value,
  }) async {
    await appBox.add(value);
  }

  /// for clearing all data in box
  Future<void> clearAllData() async {
    await appBox.clear();
  }

  void close() {
    Hive.box("cartBox").close();
  }
}
