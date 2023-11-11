import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/repository/generate_bill_repository/generate_bill_repository_pod.dart';
import '../../model/cart_food_item_model.dart';
import '../states/generate_bill_state.dart';

class SaveOrderNotifier extends AutoDisposeAsyncNotifier<SaveOrderState> {
  @override
  FutureOr<SaveOrderState> build() {
    state = const AsyncData(SaveOrderInitial());
    return future;
  }

  Future<void> createOrder(List<CartItem> cartItems) async {
    state = const AsyncLoading();

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
        state = AsyncData(SaveOrderLoaded(addOrderModel: addOrderModel));
      },
      (error) async {
        Fluttertoast.showToast(msg: error.message);
        state = AsyncError(error, StackTrace.current);
      },
    );
  }
}
