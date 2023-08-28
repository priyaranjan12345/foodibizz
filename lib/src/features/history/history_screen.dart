import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';

@RoutePage(deferredLoading: true, name: "HistoryRoute")
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                context.navigateTo(
                  const HistoryRoute(children: [HistoryDetailsRoute()]),
                );
              },
              child: const Text("History Details Screen"))
        ],
      ),
    );
  }
}
