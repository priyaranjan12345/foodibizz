import 'dart:math';

import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartStorage {
  final Box appBox;

  CartStorage({required this.appBox});

  final cartKey = 'cart';

  Future<void> addItem({required CartItem item}) async {
    final cart = getCart();

    if (cart != null) {
      var itemIndex = cart.cartItems.indexWhere(
        (e) => e.id == item.id,
      );

      if (itemIndex == -1) {
        final items = cart.cartItems;
        items.add(item);

        cart.copyWith(cartItems: items);
        await appBox.put(cartKey, cart.toJson());
      } else {
        final items = [
          for (final foodItem in cart.cartItems)
            if (foodItem.id == item.id)
              foodItem.copyWith(qty: foodItem.qty + 1)
            else
              foodItem,
        ];

        cart.copyWith(cartItems: items);

        await appBox.put(cartKey, cart.toJson());
      }
    } else {
      List<CartItem> items = [];
      items.add(item);
      await appBox.put(cartKey, Cart(cartItems: items).toJson());
    }
  }

  Cart? getCart() {
    final result = appBox.get(cartKey);

    if (result != null) {
      return Cart.fromJson(result);
    } else {
      return null;
    }
  }

  Future<void> incItemQty(int itemId) async {
    final cart = getCart();

    if (cart != null) {
      final items = [
        for (final foodItem in cart.cartItems)
          if (foodItem.id == itemId)
            foodItem.copyWith(qty: foodItem.qty + 1)
          else
            foodItem,
      ];

      cart.copyWith(cartItems: items);
      await appBox.put(cartKey, cart.toJson());
    }
  }

  Future<void> decItemQty(int itemId) async {
    final cart = getCart();

    if (cart != null) {
      final items = [
        for (final foodItem in cart.cartItems)
          if (foodItem.id == itemId)
            foodItem.copyWith(qty: max(1, foodItem.qty - 1))
          else
            foodItem,
      ];

      cart.copyWith(cartItems: items);
      await appBox.put(cartKey, cart.toJson());
    }
  }

  Future<void> deleteItem(int itemId) async {
    final cart = getCart();

    if (cart != null) {
      final items = [
        for (final foodItem in cart.cartItems)
          if (foodItem.id != itemId) foodItem,
      ];

      print(items);

      cart.copyWith(cartItems: items);

      print(cart);

      await appBox.put(cartKey, cart.toJson());
    }
  }

  Future<void> clearAllData() async {
    await appBox.delete(cartKey);
  }

  void close() {
    appBox.clear();
  }
}
