import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/generate_bill_repository/generate_bill_repository_pod.dart';
import '../../model/add_order_model.dart';
import '../../model/add_sold_item_model.dart';
import '../../model/cart_food_item_model.dart';
import '../notifiers/generate_bill_notifier.dart';
import '../states/generate_bill_state.dart';

final saveOrderProvider =
    AutoDisposeAsyncNotifierProvider<SaveOrderNotifier, SaveOrderState>(
  () => SaveOrderNotifier(),
  name: "createOrderProvider",
);

final saveOrderItemsProvider = AutoDisposeFutureProvider.family<
    List<CartFoodItemModel>,
    ({
      AddOrderModel addOrderModel,
      List<CartFoodItemModel> cartItems,
    })>((ref, args) async {
  int orderId = args.addOrderModel.id;
  List<SoldItemModel> soldItemModels = [];
  for (var billItem in args.cartItems) {
    SoldItemModel soldItemModel = SoldItemModel(
      id: DateTime.now().microsecondsSinceEpoch,
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
