import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controller/providers/cart_provider.dart';
import '../controller/providers/dashboard_provider.dart';
import '../../../core/routes/app_routes.gr.dart';
import '../../../core/localization/l10n.dart';
import '../../../../global/extensions/snackbar_ext.dart';
import '../../../../global/riverpod_ext/asyncvalue_easy_when.dart';
import '../model/all_food_items_response.dart';
import '../model/cart_food_item_model.dart';
import 'Widgets/app_search_bar.dart';

@RoutePage(deferredLoading: true, name: "DashboardRoute")
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

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
    final itemsState = ref.watch(dashboardProvider);

    /// listen deleteItemProvider
    ref.listen(
      deleteItemProvider,
      (previous, next) async {
        if (next is AsyncLoading) {
          /// show loading dialog
          await context.router.navigate(const LoadingDialogRoute());
        } else if (previous is AsyncLoading && next is AsyncData) {
          /// on success hide loading dialog
          /// need to complete the flow
          if (context.router.current.name ==
              const LoadingDialogRoute().routeName) {
            context.popRoute();
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
        } else if (previous is AsyncLoading && next is AsyncError) {
          if (context.router.current.name ==
              const LoadingDialogRoute().routeName) {
            context.popRoute();
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
        }
      },
    );

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            floating: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              child: MySearchBar(
                onTapSearch: () {
                  showSearch(
                    context: context,
                    delegate: itemsState.when(
                      data: (data) => CustomSearch(items: data.foodItems),
                      error: (_, __) => CustomSearch(items: []),
                      loading: () => CustomSearch(items: []),
                    ),
                  );
                },
                onTapCart: () {
                  context.navigateTo(const CartRecipesRoute());
                },
              ),
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(dashboardProvider.future),
          child: itemsState.easyWhen(
            // skipLoadingOnRefresh: false,
            // skipLoadingOnReload: false,
            onRetry: () {
              ref.invalidate(dashboardProvider);
            },
            data: (value) {
              return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 100,
                ),
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
                              "FoodiBizz",
                              style: Theme.of(context).textTheme.displaySmall,
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
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "http://3.27.90.34:8000/${item.image}",
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
                                                AddUpdateItemRoute(
                                                    item: item));
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
                                                .read(deleteItemProvider
                                                    .notifier)
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
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item.desc),
                        ),
                        ListTile(
                          leading: FilledButton(
                            onPressed: () {
                              onTapAddItem(item, ref);
                              final snackBar = SnackBar(
                                content: Text("${item.name} Item added"),
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
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final status = await context.pushRoute(
            AddUpdateItemRoute(),
          );
          if (status == 1) ref.invalidate(dashboardProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  CustomSearch({required this.items});
  final List<FoodItem> items;

  void onTapAdd(
      {required FoodItem cartItem,
      required WidgetRef ref,
      required BuildContext context}) {
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

// class MyDynamicHeader extends SliverPersistentHeaderDelegate {
//   int index = 0;
//   double maxExt = 0;
//   double minExt = 0;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double percentage =
//             (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

//         if (++index > Colors.primaries.length - 1) index = 0;

//         return Container(
//           decoration: const BoxDecoration(
//             boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
//             color: Colors.red,
//           ),
//           height: constraints.maxHeight,
//           child: SafeArea(
//             child: Center(
//               child: CircularProgressIndicator(
//                 value: percentage,
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

//   @override
//   double get maxExtent => maxExt;

//   @override
//   double get minExtent => minExt;
// }
