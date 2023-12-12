import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/notifiers/generate_bill_notifier.dart';
import 'package:foodibizz/src/features/dashboard/controller/states/generate_bill_state.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/generate_bill_repository/generate_bill_repository_pod.dart';
import 'package:foodibizz/src/features/dashboard/model/add_order_model.dart';
import 'package:foodibizz/src/features/dashboard/model/add_sold_item_model.dart';
import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';



final saveOrderProvider =
    AutoDisposeAsyncNotifierProvider<SaveOrderNotifier, SaveOrderState>(
  () => SaveOrderNotifier(),
  name: "createOrderProvider",
);

final saveOrderItemsProvider = AutoDisposeFutureProvider.family<
    List<CartItem>,
    ({
      AddOrderModel addOrderModel,
      List<CartItem> cartItems,
    })>((ref, args) async {
  int orderId = args.addOrderModel.id;
  List<SoldItemModel> soldItemModels = [];
  final random = Random();
  for (var billItem in args.cartItems) {
    SoldItemModel soldItemModel = SoldItemModel(
      id: DateTime.now().microsecondsSinceEpoch + random.nextInt(1000),
      itemQty: billItem.qty,
      orderId: orderId,
      itemId: billItem.id,
      itemUnitPrice: billItem.price,
    );
    soldItemModels.add(soldItemModel);
  }

  AddSoldItemModel addSoldItemModel = AddSoldItemModel(
    soldItemModels: soldItemModels,
  );

  final result = await ref.watch(generateBillRepoPod).saveBillItems(
        addSoldItemModel: addSoldItemModel,
      );

  return result.when(
    (success) => args.cartItems,
    (error) => throw error,
  );
});
