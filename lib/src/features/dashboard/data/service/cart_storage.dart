import 'dart:math';

import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartStorage {
  Box<CartFoodItemModel> appBox;

  CartStorage(this.appBox);

  /// for storing value on defined key
  /// on the box
  Future<void> addItem({required CartFoodItemModel item}) async {
    var itemIndex = appBox.values.toList().indexWhere(
          (e) => e.id == item.id,
        );

    if (itemIndex == -1) {
      await appBox.add(item);
    } else {
      await incItemQty(item.id);
    }
  }

  Future<void> incItemQty(int itemId) async {
    final items = [
      for (final foodItem in appBox.values)
        if (foodItem.id == itemId)
          foodItem.copyWith(qty: foodItem.qty + 1)
        else
          foodItem,
    ];

    await appBox.clear();
    appBox.addAll(items);
  }

  Future<void> decItemQty(int itemId) async {
    final items = [
      for (final foodItem in appBox.values)
        if (foodItem.id == itemId)
          foodItem.copyWith(qty: max(1, foodItem.qty - 1))
        else
          foodItem,
    ];

    await appBox.clear();
    appBox.addAll(items);
  }

  void deleteItem(int itemId) {
    var itemIndex = appBox.values.toList().indexWhere(
          (item) => item.id == itemId,
        );
    appBox.deleteAt(itemIndex);
  }

  /// for clearing all data in box
  Future<void> clearAllData() async {
    await appBox.clear();
  }

  void close() {
    Hive.box("cartBox").close();
  }
}
