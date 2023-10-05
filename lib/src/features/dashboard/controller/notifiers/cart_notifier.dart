import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/all_food_items_response.dart';
import '../../model/cart_food_item_model.dart';
import '../providers/cart_provider.dart';

class CartNotifier extends AutoDisposeNotifier<List<CartFoodItemModel>> {
  Box? box;
  final String boxName = "cartBox";

  @override
  List<CartFoodItemModel> build() {
    state = <CartFoodItemModel>[];
    init();
    return state;
  }

  void init() {
    box = ref.watch(cartBoxProvider);
    state = box?.get(boxName) ?? <CartFoodItemModel>[];
  }

  void addItem(FoodItem cartItem) {
    var foodItemIndex = state.indexWhere(
      (element) => element.id == cartItem.id,
    );

    if (foodItemIndex == -1) {
      final cartItemModel = CartFoodItemModel(
        id: cartItem.id,
        name: cartItem.name,
        desc: cartItem.desc,
        image: cartItem.image,
        price: cartItem.price,
        creationDate: cartItem.creationDate,
        lastModifiedDate: cartItem.lastModifiedDate,
        qty: 1,
      );

      state = [...state, cartItemModel];
    } else {
      state = [
        for (final item in state)
          if (item.id == cartItem.id)
            item.copyWith(qty: state[foodItemIndex].qty + 1)
          else
            item,
      ];
    }

    box?.put(boxName, state);
    state = box?.get(boxName) ?? <CartFoodItemModel>[];
  }

  void incItemQty(int itemId) {
    state = [
      for (final item in state)
        if (item.id == itemId) item.copyWith(qty: item.qty + 1) else item,
    ];

    box?.put(boxName, state);
    state = box?.get(boxName) ?? <CartFoodItemModel>[];
  }

  void decItemQty(int itemId) {
    state = [
      for (final item in state)
        if (item.id == itemId) item.copyWith(qty: item.qty - 1) else item,
    ];

    box?.put(boxName, state);
    state = box?.get(boxName) ?? <CartFoodItemModel>[];
  }

  void removeItem(int itemId) {
    state = [
      for (final foodItem in state)
        if (foodItem.id != itemId) foodItem,
    ];
  }
}
