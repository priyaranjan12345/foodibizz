import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';

@RoutePage(deferredLoading: true, name: "AllOrdersRoute")
class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const Text("all orders"),
          ElevatedButton(
            onPressed: () {
              context.navigateTo(const OrderDetailsRoute());
            },
            child: const Text("Order Details"),
          ),
        ],
      ),
    );
  }
}
