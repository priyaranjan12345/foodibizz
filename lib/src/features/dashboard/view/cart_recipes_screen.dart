import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodibizz/src/core/constants/gaps.dart';
import 'package:foodibizz/src/features/dashboard/controller/providers/cart_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/cart_food_item_model.dart';

@RoutePage(deferredLoading: true, name: "CartRecipesRoute")
class CartRecipesScreen extends ConsumerWidget {
  const CartRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartBoxProvider).listenable();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Billing Items"),
      ),
      //TODO
      body: ValueListenableBuilder(
        valueListenable: items,
        builder: (context, box, __) {
          return ListView.separated(
            itemCount: box.values.toList()[0].length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, index) {
              final item = box.values.toList()[0][index];
              return CartItemTile(
                item: item,
              );
            },
          );
        },
      ),
      bottomNavigationBar: ListTile(
        title: const Text(
          "Grand Total:  \u{20B9} 100",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text("GST: 0 \t Discount: 0"),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text("Generate Bill"),
        ),
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
  });

  final CartFoodItemModel item;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(1),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: CachedNetworkImage(
            imageUrl: "http://3.27.90.34:8000/${item.image}",
          ),
        ),
        title: Text(item.name),
        subtitle: Text("Unit Price: ${item.price.toString()}"),
        trailing: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 15,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove,
                      size: 15,
                    ),
                  ),
                ),
                gapW8,
                Text(
                  item.qty.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                gapW8,
                CircleAvatar(
                  radius: 15,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "\u{20B9} ${item.qty * item.price}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
