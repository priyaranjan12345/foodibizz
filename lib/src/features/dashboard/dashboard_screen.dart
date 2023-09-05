import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/riverpod_ext/asyncvalue_easy_when.dart';
import 'package:foodibizz/src/core/localization/l10n.dart';
import 'package:foodibizz/src/features/dashboard/controller/dashboard_provider.dart';

@RoutePage(deferredLoading: true, name: "DashboardRoute")
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final itemsState = ref.watch(dashboardProvider);
            return itemsState.easyWhen(
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
                      itemBuilder: (context, index) {
                        final data = value.foodItems[index];
                        return Card(
                          elevation: 5.0,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "http://3.27.90.34:8000/${data.image}",
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
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
                                              constraints:
                                                  const BoxConstraints(),
                                              color: Colors.white,
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<String>>[
                                                PopupMenuItem<String>(
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    onTap: () {},
                                                    leading:
                                                        const Icon(Icons.edit),
                                                    title: Text(l10n.edit),
                                                  ),
                                                ),
                                                PopupMenuItem<String>(
                                                    child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  onTap: () {},
                                                  leading:
                                                      const Icon(Icons.delete),
                                                  title: Text(l10n.delete),
                                                )),
                                              ],
                                            )),
                                      ))
                                ],
                              ),
                              ListTile(
                                title: Text(
                                  data.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(data.desc),
                              ),
                              ListTile(
                                leading: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 5.0),
                                    onPressed: () {},
                                    child: Text(l10n.buy)),
                                trailing: Text(
                                  "\u{20B9} ${data.price}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                );
              },
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

// SearchBar(
//               padding: MaterialStateProperty.all(
//                 const EdgeInsets.symmetric(horizontal: 10),
//               ),
//               elevation: MaterialStateProperty.all(1),
//               leading: const Icon(Icons.menu),
//               trailing: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.search),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.shopping_cart_outlined),
//                 ),
//               ],
//             ),
