import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart.dart';

// hive database list item qty, model avoid adapter // cart
// clear list
// loading dialog not working after error delete

@RoutePage(deferredLoading: true, name: "CartRecipesRoute")
class CartRecipesScreen extends ConsumerWidget {
  const CartRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartStorageProvider).getCart()?.cartItems ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              child: IconButton(
                onPressed: () {
                  ref.read(cartStorageProvider).clearAllData();
                },
                icon: const Icon(Icons.remove_shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) {
          final item = items[index];
          return CartItemTile(
            item: item,
          );
        },
      ),
      bottomNavigationBar: ListTile(
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
      ),
    );
  }
}
