import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodibizz/src/features/dashboard/controller/providers/cart_provider.dart';
import 'package:foodibizz/src/features/dashboard/view/widgets/cart_widgets/cart_item_tile.dart';
import 'package:foodibizz/src/features/dashboard/view/widgets/cart_widgets/empty_cart.dart';
import 'package:foodibizz/src/features/dashboard/view/widgets/save_order_button.dart';

@RoutePage(deferredLoading: true, name: "CartRecipesRoute")
class CartRecipesScreen extends ConsumerWidget {
  const CartRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartItemProvide);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
        actions: [
          if (items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                child: IconButton(
                  onPressed: () {
                    ref.read(cartItemProvide.notifier).deleteAllItems();
                  },
                  icon: const Icon(Icons.remove_shopping_cart_outlined),
                ),
              ),
            ),
        ],
      ),
      body: items.isEmpty
          ? const EmptyCart()
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, index) {
                final item = items[index];
                return CartItemTile(
                  item: item,
                );
              },
            ),
      bottomNavigationBar: (items.isNotEmpty)
          ? ListTile(
              title: Text(
                "Grand Total:  \u{20B9} ${items.fold(0.0, (previousValue, element) => double.parse(previousValue.toString()) + (element.price * element.qty))}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text("GST: 0 \t Discount: 0"),
              trailing: SaveOrderButton(
                cartItems: items.toList(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
