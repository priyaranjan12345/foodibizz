import 'package:flutter/material.dart';

class FoodibizzCard extends StatelessWidget {
  const FoodibizzCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "FoodiBizz",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            const Text(
              "The display showcases all items the user can see, "
              "arranged in an organized and visually appealing manner.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}