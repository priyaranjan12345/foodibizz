import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/repository/generate_bill_repository/generate_bill_repository_pod.dart';
import '../../model/add_sold_item_model.dart';
import '../../model/cart_food_item_model.dart';
import '../states/generate_bill_state.dart';

class GenerateBillNotifier extends AutoDisposeAsyncNotifier<GenerateBillState> {
  @override
  FutureOr<GenerateBillState> build() {
    state = const AsyncData(GenerateBillInitial());
    return future;
  }

  Future<void> createOrder(List<CartFoodItemModel> cartItems) async {
    int noOfItems = cartItems.length;
    double total = cartItems.isNotEmpty
        ? cartItems
            .map<double>((item) => item.qty * item.price)
            .reduce((value1, value2) => value1 + value2)
        : 0.0;

    final result = await ref.watch(generateBillRepoPod).createOrder(
          dateTime: DateTime.now().toString(),
          invNo: 'INV${DateTime.now().millisecondsSinceEpoch}',
          noOfItems: noOfItems,
          gst: 0,
          discount: 0,
          grandTotal: total,
        );

    result.when(
      (addOrderModel) async {
        int orderId = addOrderModel.id;
        List<SoldItemModel> soldItemModels = [];
        for (var billItem in cartItems) {
          SoldItemModel soldItemModel = SoldItemModel(
            id: 0,
            itemQty: billItem.qty,
            orderId: orderId,
            itemId: billItem.id,
            itemUnitPrice: billItem.price,
          );
          soldItemModels.add(soldItemModel);
        }
        AddSoldItemModel addSoldItemModel =
            AddSoldItemModel(soldItemModels: soldItemModels);
        await addSoldItems(addSoldItemModel);
        state = const AsyncData(GeneratedBill());
      },
      (error) async {
        Fluttertoast.showToast(msg: error.message);
        state = AsyncError(error, StackTrace.current);
      },
    );
  }

  Future<void> addSoldItems(AddSoldItemModel addSoldItemModel) async {
    final result = await ref.watch(generateBillRepoPod).saveBillItems(
          addSoldItemModel: addSoldItemModel,
        );

    result.when(
      (addSoldItemModel) {
        Fluttertoast.showToast(msg: "items saved");
      },
      (error) {
        Fluttertoast.showToast(msg: error.message);
      },
    );
  }
}

// class SaveBillItemNotifier extends AutoDisposeAsyncNotifier {
//   @override
//   FutureOr build() {
//     return future;
//   }

//   Future<void> addSoldItems() async {
//     final createOrderState = ref.watch(createOrderProvider);
//     createOrderState.when(
//       data: (p0) {},
//       error: (_, __) {},
//       loading: () {},
//     );
//   }
// }
