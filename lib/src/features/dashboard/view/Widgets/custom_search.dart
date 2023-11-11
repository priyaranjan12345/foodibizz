import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/extensions/snackbar_ext.dart';
import '../../controller/providers/cart_provider.dart';
import '../../model/all_food_items_response.dart';
import '../../model/cart_food_item_model.dart';

class CustomSearch extends SearchDelegate {
  CustomSearch({required this.items});
  final List<FoodItem> items;

  void onTapAdd(
      {required FoodItem cartItem,
      required WidgetRef ref,
      required BuildContext context}) {
    ref.read(cartItemProvide.notifier).addItem(
          cartItem: CartItem(
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

    final snackBar = SnackBar(
      content: Text("${cartItem.name} Item added"),
      action: SnackBarAction(
          label: "Close",
          onPressed: () {
            context.hideSnackBar();
          }),
    );
    context.clearSnackBar();
    context.showSnackBar(snackBar);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<FoodItem> matchQuery = [];

    for (var item in items) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.separated(
      itemCount: matchQuery.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = matchQuery[index];
        return ListTile(
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
          trailing: Consumer(builder: (_, ref, __) {
            return FilledButton.tonal(
              onPressed: () => onTapAdd(
                cartItem: item,
                ref: ref,
                context: context,
              ),
              child: const Text("Add to cart"),
            );
          }),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<FoodItem> matchQuery = [];

    for (var item in items) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.separated(
      itemCount: matchQuery.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = matchQuery[index];
        return ListTile(
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
          trailing: Consumer(builder: (_, ref, __) {
            return FilledButton.tonal(
              onPressed: () => onTapAdd(
                cartItem: item,
                ref: ref,
                context: context,
              ),
              child: const Text("Add to cart"),
            );
          }),
        );
      },
    );
  }
}
