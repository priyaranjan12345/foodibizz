import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodibizz/src/core/constants/gaps.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.add_shopping_cart,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        gapH20,
        Text(
          "Cart is empty, add items to your cart.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        gapH12,
        Center(
          child: ElevatedButton(
            onPressed: () {
              context.router.pop();
            },
            child: const Text("Goto Items"),
          ),
        ),
      ],
    );
  }
}
