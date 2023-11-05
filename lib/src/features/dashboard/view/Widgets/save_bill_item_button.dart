import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/routes/app_routes.gr.dart';
import '../../controller/providers/generate_bill_provider.dart';
import '../../model/add_order_model.dart';
import '../../model/cart_food_item_model.dart';

class SaveBillItemButton extends ConsumerWidget {
  const SaveBillItemButton({
    super.key,
    required this.addOrderModel,
    required this.cartItems,
  });

  final AddOrderModel addOrderModel;
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ({AddOrderModel addOrderModel, List<CartItem> cartItems}) recod =
        (addOrderModel: addOrderModel, cartItems: cartItems);

    final saveOrderAsync = ref.watch(saveOrderItemsProvider(recod));

    ref.listen(
      saveOrderItemsProvider(recod),
      (previous, next) {
        next.when(
          data: (data) {
            context.navigateTo(
              BillingRoute(cbl: data),
            );
          },
          error: (_, __) {
            Fluttertoast.showToast(msg: "Unable to save bill items");
          },
          loading: () {
            Fluttertoast.showToast(msg: "Loading please wait");
          },
        );
      },
    );

    return saveOrderAsync.when(
      data: (saveOrderItemsState) => const ElevatedButton(
        onPressed: null,
        child: Text("Bill Generated"),
      ),
      error: (_, __) => ElevatedButton(
        onPressed: () {
          ref.invalidate(saveOrderItemsProvider(recod));
        },
        child: const Text("Retry"),
      ),
      loading: () => ElevatedButton(
        onPressed: () {},
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
