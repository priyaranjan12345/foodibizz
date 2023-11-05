import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/extensions/snackbar_ext.dart';
import 'package:foodibizz/src/features/dashboard/view/Widgets/save_bill_item_button.dart';

import '../../controller/providers/generate_bill_provider.dart';
import '../../controller/states/generate_bill_state.dart';
import '../../model/cart_food_item_model.dart';

class SaveOrderButton extends ConsumerWidget {
  const SaveOrderButton({
    super.key,
    required this.cartItems,
  });

  final List<CartItem> cartItems;

  void onSubmit(WidgetRef ref) {
    ref.read(saveOrderProvider.notifier).createOrder(cartItems);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveOrderAsync = ref.watch(saveOrderProvider);

    ref.listen(
      saveOrderProvider,
      (previous, next) {
        next.when(
          data: (data) => switch (data) {
            SaveOrderInitial() => null,
            SaveOrderLoaded() => null,
          },
          error: (e, _) {
            /// show error snackbar
            final snackBar = SnackBar(content: Text("Error: ${e.toString()}"));
            context.showSnackBar(snackBar);
          },
          loading: () {
            // show loading dialog
          },
        );
      },
    );

    return saveOrderAsync.when(
      data: (saveOrderState) => switch (saveOrderState) {
        SaveOrderInitial() => ElevatedButton(
            onPressed: () => onSubmit(ref),
            child: const Text("Generate Bill"),
          ),
        SaveOrderLoaded() => SaveBillItemButton(
            addOrderModel: saveOrderState.addOrderModel,
            cartItems: cartItems,
          ),
      },
      error: (_, __) => ElevatedButton(
        onPressed: () => onSubmit(ref),
        child: const Text("Retry"),
      ),
      loading: () => ElevatedButton(
        onPressed: () {},
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
