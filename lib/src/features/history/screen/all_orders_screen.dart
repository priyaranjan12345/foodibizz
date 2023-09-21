import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';

@RoutePage(deferredLoading: true, name: "AllOrdersRoute")
class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  context.navigateTo(const OrderDetailsRoute());
                },
                leading: const CircleAvatar(child: Text("10")),
                trailing: const Icon(Icons.chevron_right),
                title: const Text("Invoice number"),
                subtitle: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("11/12/2023"), Text("\u{20B9} 122")],
                ),
              );
            }));
  }
}
