import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controller/providers/dashboard_provider.dart';
import '../../../core/routes/app_routes.gr.dart';
import '../../../core/localization/l10n.dart';
import '../../../../global/extensions/snackbar_ext.dart';
import '../../../../global/riverpod_ext/asyncvalue_easy_when.dart';

@RoutePage(deferredLoading: true, name: "DashboardRoute")
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboard),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.navigateTo(
            const AddUpdateItemRoute(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: itemsState.easyWhen(
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
                itemCount: value.foodItems.length,
                itemBuilder: (_, index) {
                  final item = value.foodItems[index];
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
                                      .withOpacity(0.4),
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
                            onPressed: () {},
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
  List<String> fruitList = [
    'Apple',
    'Banana',
    'Peach',
    'Avocado',
    'Orange',
    'Pear',
    'Watermelon',
    'pineapple',
  ];

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

    for (var fruit in fruitList) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchQuery[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var fruit in fruitList) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchQuery[index]),
        );
      },
    );
  }
}
