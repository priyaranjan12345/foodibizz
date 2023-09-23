import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodibizz/src/features/dashboard/controller/providers/cart_provider.dart';
import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';

import '../controller/providers/dashboard_provider.dart';
import '../../../core/routes/app_routes.gr.dart';
import '../../../core/localization/l10n.dart';
import '../../../../global/extensions/snackbar_ext.dart';
import '../../../../global/riverpod_ext/asyncvalue_easy_when.dart';
import '../model/all_food_items_response.dart';
import 'Widgets/app_search_bar.dart';

@RoutePage(deferredLoading: true, name: "DashboardRoute")
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  void onTapAddItem(FoodItem cartItem, WidgetRef ref) {
    List<CartFoodItemModel> items = [];
    List<CartFoodItemModel> allItems =
        ref.read(cartStorageProvider).get(key: "cart");

    var foodItemIndex = allItems.indexWhere(
      (element) => element.id == cartItem.id,
    );

    if (foodItemIndex == -1) {
      final cartItemModel = CartFoodItemModel(
        id: cartItem.id,
        name: cartItem.name,
        desc: cartItem.desc,
        image: cartItem.image,
        price: cartItem.price,
        creationDate: cartItem.creationDate,
        lastModifiedDate: cartItem.lastModifiedDate,
        qty: 1,
      );
      items = [...allItems, cartItemModel];
    } else {
      final cartItemModel = CartFoodItemModel(
        id: cartItem.id,
        name: cartItem.name,
        desc: cartItem.desc,
        image: cartItem.image,
        price: cartItem.price,
        creationDate: cartItem.creationDate,
        lastModifiedDate: cartItem.lastModifiedDate,
        qty: 1,
      );

      items = [
        for (final item in allItems)
          if (item.id == cartItemModel.id)
            item.copyWith(qty: allItems[foodItemIndex].qty + 1)
          else
            item,
      ];
    }

    ref.read(cartStorageProvider).put(
          key: "cart",
          values: items,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final itemsState = ref.watch(dashboardProvider);

    /// listen deleteItemProvider
    ref.listen(
      deleteItemProvider,
      (previous, next) {
        next.when(
          data: (_) {
            /// on success hide loading dialog
            /// need to complete the flow
            if (context.router.current.name == "LoadingDialogRoute") {
              context.back();
            }

            /// on success refresh list
            /// to get updated items list
            ref.invalidate(dashboardProvider);

            final snackBar = SnackBar(
              content: const Text("Item deleted"),
              action: SnackBarAction(
                label: "Cancel",
                onPressed: () {
                  context.hideSnackBar();
                },
              ),
            );

            /// show snackbar
            context.showSnackBar(snackBar);
          },
          error: (e, _) {
            /// on error hide loading dialog
            /// need to complete the flow
            if (context.router.current.name == "LoadingDialogRoute") {
              context.back();
            }

            /// clear all previous snackbars
            context.clearSnackBar();

            /// error snackbar
            final snackBar = SnackBar(
              content: const Text("Failed to delete item"),
              action: SnackBarAction(
                label: "Cancel",
                onPressed: () {
                  context.hideSnackBar();
                },
              ),
            );

            /// show error snackbar
            context.showSnackBar(snackBar);
          },
          loading: () {
            /// show loading dialog
            context.router.navigate(const LoadingDialogRoute());
          },
        );
      },
    );

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight + 10),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              child: MySearchBar(
                onTapSearch: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearch(items: []),
                  );
                },
                onTapCart: () {
                  context.navigateTo(const CartRecipesRoute());
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.navigateTo(
              AddUpdateItemRoute(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: itemsState.easyWhen(
          onRetry: () {
            ref.invalidate(dashboardProvider);
          },
          data: (value) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(dashboardProvider);
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: value.foodItems.length + 1,
                itemBuilder: (_, index) {
                  if (index == 0) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Items",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "The display showcases all items the user can see, "
                              "arranged in an organized and visually appealing manner.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  final item = value.foodItems[index - 1];
                  return Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: "http://3.27.90.34:8000/${item.image}",
                              errorWidget: (context, url, error) =>
                                  Image.asset('nope-not-here.webp'),
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
                                  backgroundColor: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.6),
                                  child: PopupMenuButton<String>(
                                    padding: EdgeInsets.zero,
                                    elevation: 5.0,
                                    constraints: const BoxConstraints(),
                                    itemBuilder: (BuildContext ctx) =>
                                        <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          onTap: () {
                                            Navigator.pop(ctx);
                                            context.navigateTo(
                                                AddUpdateItemRoute(item: item));
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
                                            final id = item.id.toString();
                                            ref
                                                .read(
                                                    deleteItemProvider.notifier)
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
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item.desc),
                        ),
                        ListTile(
                          leading: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 5.0),
                            onPressed: () => onTapAddItem(item, ref),
                            child: Text(l10n.buy),
                          ),
                          trailing: Text(
                            "\u{20B9} ${item.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  CustomSearch({required this.items});
  final List<FoodItem> items;

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
    List<String> matchQuery = [];

    for (var item in items) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item.name);
      }
    }

    return ListView.separated(
      itemCount: matchQuery.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(matchQuery[index]),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var item in items) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item.name);
      }
    }

    return ListView.separated(
      itemCount: matchQuery.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(matchQuery[index]),
          ),
        );
      },
    );
  }
}
