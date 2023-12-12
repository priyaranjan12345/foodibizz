import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/providers/cart_provider.dart';
import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';

class CartNotifier extends AutoDisposeNotifier<List<CartItem>> {
  final cartKey = 'cartItem';

  @override
  List<CartItem> build() {
    return getCartItems();
  }

  List<CartItem> getCartItems() {
    final box = ref.read(cartBoxProvider);
    final response = box.get(cartKey);

    if (response != null && response != '') {
      final result = jsonDecode(response);
      final cartItems = List<CartItem>.from(
        result.map((e) => CartItem.fromJson(e)),
      );

      return cartItems;
    } else {
      return [];
    }
  }

  void addItem({required CartItem cartItem}) async {
    final box = ref.read(cartBoxProvider);
    final cartItems = getCartItems();

    if (cartItems.isNotEmpty) {
      var itemIndex = cartItems.indexWhere(
        (e) => e.id == cartItem.id,
      );

      if (itemIndex == -1) {
        final items = cartItems;
        items.add(cartItem);
        await box.put(cartKey, jsonEncode(items));
      } else {
        final items = [
          for (final item in cartItems)
            if (item.id == cartItem.id)
              item.copyWith(qty: item.qty + 1)
            else
              item,
        ];

        await box.put(cartKey, jsonEncode(items));
      }
    } else {
      List<CartItem> items = [];
      items.add(cartItem);
      await box.put(cartKey, jsonEncode(items));
    }

    ref.invalidateSelf();
  }

  void deleteItem({required int itemId}) async {
    final box = ref.read(cartBoxProvider);
    final cartItems = getCartItems();
    cartItems.removeWhere((element) => element.id == itemId);
    await box.put(cartKey, jsonEncode(cartItems));
    ref.invalidateSelf();
  }

  void deleteAllItems() async {
    final box = ref.read(cartBoxProvider);
    await box.delete(cartKey);
    ref.invalidateSelf();
  }

  void incItemQty({required int itemId}) async {
    final box = ref.read(cartBoxProvider);
    final cartItems = getCartItems();

    if (cartItems.isNotEmpty) {
      final items = [
        for (final item in cartItems)
          if (item.id == itemId) item.copyWith(qty: item.qty + 1) else item,
      ];

      await box.put(cartKey, jsonEncode(items));
    }

    ref.invalidateSelf();
  }

  void decItemQty({required int itemId}) async {
    final box = ref.read(cartBoxProvider);
    final cartItems = getCartItems();

    if (cartItems.isNotEmpty) {
      final items = [
        for (final item in cartItems)
          if (item.id == itemId)
            item.copyWith(qty: max(1, item.qty - 1))
          else
            item,
      ];

      await box.put(cartKey, jsonEncode(items));
    }

    ref.invalidateSelf();
  }
}
