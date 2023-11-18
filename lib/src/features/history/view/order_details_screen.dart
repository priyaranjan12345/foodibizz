import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/riverpod_ext/asyncvalue_easy_when.dart';

import '../../../../global/api_client/base_url_pod.dart';
import '../controller/providers/order_details_provider.dart';

@RoutePage(deferredLoading: true, name: "OrderDetailsRoute")
class OrderDetailsScreen extends ConsumerWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderItemsState = ref.watch(orderDetailsProvider(orderId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Items'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.receipt_sharp),
              ),
            ),
          ),
        ],
      ),
      body: orderItemsState.easyWhen(
        data: (data) {
          final orderItems = data.allSoldItems;
          return ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            itemCount: orderItems.length,
            itemBuilder: (_, index) {
              final orderItem = orderItems[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "${ref.read(baseUrlProvider)}${orderItem.image}",
                  ),
                ),
                title: Text(orderItem.name),
                subtitle: Text("Unit Price: ${orderItem.price.toString()}"),
                trailing: Text(
                  "Qty: ${orderItem.itemQty}",
                  style: const TextStyle(fontSize: 15),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
