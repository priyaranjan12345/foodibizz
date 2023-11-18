import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../core/constants/gaps.dart';
import '../../../controller/providers/cart_provider.dart';
import '../../../model/cart_food_item_model.dart';

class CartItemTile extends ConsumerWidget {
  const CartItemTile({
    super.key,
    required this.item,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: const ValueKey(1),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onPressed: (context) {
              ref.read(cartItemProvide.notifier).deleteItem(itemId: item.id);
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: Icons.delete,
            spacing: 10,
          ),
          SlidableAction(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onPressed: (context) {},
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icons.close,
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
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      ref
                          .read(cartItemProvide.notifier)
                          .decItemQty(itemId: item.id);
                    },
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
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      ref
                          .read(cartItemProvide.notifier)
                          .incItemQty(itemId: item.id);
                    },
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
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
