import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/global/riverpod_ext/asyncvalue_easy_when.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';
import 'package:foodibizz/src/features/history/controller/providers/all_orders_provider.dart';

@RoutePage(deferredLoading: true, name: "AllOrdersRoute")
class AllOrdersScreen extends ConsumerWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(allOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      body: ordersState.easyWhen(
        errorWidget: (error, stackTrace) =>
            Text((error as BaseException).message.toString()),
        data: (value) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(allOrdersProvider);
            },
            child: ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: value.allOrders.length,
              itemBuilder: (_, index) {
                final order = value.allOrders[index];

                return ListTile(
                  onTap: () {
                    context.navigateTo(OrderDetailsRoute(orderId: order.id));
                  },
                  leading: CircleAvatar(child: Text((index + 1).toString())),
                  trailing: const Icon(Icons.chevron_right),
                  title: Text(order.invNum.toString()),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(order.billingDate.split('T')[0]),
                      Text("\u{20B9} ${order.grandTotal}")
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
