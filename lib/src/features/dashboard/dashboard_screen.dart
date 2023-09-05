import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/dashboard_provider.dart';

@RoutePage(deferredLoading: true, name: "DashboardRoute")
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
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
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final itemsState = ref.watch(dashboardProvider);
            return itemsState.when(
              data: (data) {
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(dashboardProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: data.foodItems.length,
                    itemBuilder: (context, index) => Card(
                      child: Column(
                        children: [
                          Text(data.foodItems[index].name),
                          Text(data.foodItems[index].desc),
                        ],
                      ),
                    ),
                  ),
                );
              },
              error: (error, stackTrace) => const Text("error"),
              loading: () => const CircularProgressIndicator(),
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
