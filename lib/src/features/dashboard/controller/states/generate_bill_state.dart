import 'package:meta/meta.dart';
import 'package:foodibizz/src/features/dashboard/model/add_order_model.dart';
import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';

// save order states
@immutable
sealed class SaveOrderState {
  const SaveOrderState();
}

class SaveOrderInitial implements SaveOrderState {
  const SaveOrderInitial() : super();
}

class SaveOrderLoaded implements SaveOrderState {
  final AddOrderModel addOrderModel;

  const SaveOrderLoaded({required this.addOrderModel}) : super();
}

// save order items
@immutable
sealed class SaveOrderItemsState {
  const SaveOrderItemsState();
}

class SaveOrderItemsInitial implements SaveOrderItemsState {
  const SaveOrderItemsInitial() : super();
}

class SaveOrderItemsLoaded implements SaveOrderItemsState {
  final List<CartItem> cartItems;
  const SaveOrderItemsLoaded({required this.cartItems}) : super();
}
