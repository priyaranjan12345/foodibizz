import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodibizz/global/extensions/snackbar_ext.dart';
import 'package:foodibizz/global/riverpod_ext/asyncvalue_easy_when.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';
import 'package:foodibizz/src/features/dashboard/controller/providers/dashboard_provider.dart';
import 'package:foodibizz/src/features/dashboard/view/widgets/dashboard_widgets/app_search_bar.dart';
import 'package:foodibizz/src/features/dashboard/view/widgets/dashboard_widgets/custom_search.dart';
import 'package:foodibizz/src/features/dashboard/view/widgets/dashboard_widgets/foodibizz_card.dart';
import 'package:foodibizz/src/features/dashboard/view/widgets/dashboard_widgets/item_card.dart';


@RoutePage(deferredLoading: true, name: "DashboardRoute")
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  void listenDeleteItem(BuildContext context, WidgetRef ref) {
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
              label: "Close",
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
              label: "Close",
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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(dashboardProvider);

    /// listen deleteItemProvider
    listenDeleteItem(context, ref);

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              pinned: false,
              snap: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6),
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
              onRetry: () {
                ref.invalidate(dashboardProvider);
              },
              data: (value) {
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 100,
                  ),
                  itemCount: value.foodItems.length + 1,
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      return const FoodibizzCard();
                    }
                    final item = value.foodItems[index - 1];
                    return ItemCard(foodItem: item);
                  },
                );
              },
            ),
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
