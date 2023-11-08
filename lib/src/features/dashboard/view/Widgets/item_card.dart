import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/extensions/snackbar_ext.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';

import '../../controller/providers/cart_provider.dart';
import '../../controller/providers/dashboard_provider.dart';
import '../../model/all_food_items_response.dart';
import '../../model/cart_food_item_model.dart';

class ItemCard extends ConsumerWidget {
  const ItemCard({
    super.key,
    required this.foodItem,
  });

  final FoodItem foodItem;

  void onTapAddItem(FoodItem cartItem, WidgetRef ref) {
    ref.read(cartStorageProvider).addItem(
          item: CartItem(
            id: cartItem.id,
            name: cartItem.name,
            desc: cartItem.desc,
            image: cartItem.image,
            price: cartItem.price,
            creationDate: cartItem.creationDate,
            lastModifiedDate: cartItem.lastModifiedDate,
            qty: 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: "http://3.27.90.34:8000/${foodItem.image}",
                errorWidget: (context, url, error) =>
                    Image.asset('assets/no-image.jpg'),
                placeholder: (context, url) =>
                    Image.asset('assets/no-image.jpg'),
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor:
                        Theme.of(context).cardColor.withOpacity(0.6),
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      elevation: 5.0,
                      constraints: const BoxConstraints(),
                      itemBuilder: (BuildContext ctx) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            onTap: () async {
                              Navigator.pop(ctx);
                              final status = await context.pushRoute(
                                AddUpdateItemRoute(item: foodItem),
                              );

                              if (status == 1) {
                                ref.invalidate(dashboardProvider);
                              }
                            },
                            leading: const Icon(Icons.edit),
                            title: Text(l10n.edit),
                          ),
                        ),
                        PopupMenuItem<String>(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            onTap: () {
                              Navigator.pop(ctx);
                              final id = foodItem.id.toString();
                              ref
                                  .read(deleteItemProvider.notifier)
                                  .onTapDelete(id);
                            },
                            leading: const Icon(Icons.delete),
                            title: Text(l10n.delete),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          ListTile(
            title: Text(
              foodItem.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(foodItem.desc),
          ),
          ListTile(
            leading: FilledButton(
              onPressed: () {
                onTapAddItem(foodItem, ref);
                final snackBar = SnackBar(
                  content: Text("${foodItem.name} Item added"),
                  action: SnackBarAction(
                      label: "Close",
                      onPressed: () {
                        context.hideSnackBar();
                      }),
                );
                context.clearSnackBar();
                context.showSnackBar(snackBar);
              },
              child: Text(l10n.addToCart),
            ),
            trailing: Text(
              "\u{20B9} ${foodItem.price}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
