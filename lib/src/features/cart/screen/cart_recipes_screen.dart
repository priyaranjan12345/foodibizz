import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodibizz/src/core/constants/gaps.dart';

@RoutePage(deferredLoading: true, name: "CartRecipesRoute")
class CartRecipesScreen extends StatelessWidget {
  const CartRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(index),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: ListTile(
                title: const Text('Biriyani'),
                trailing: Consumer(builder: (context, ref, _) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove,
                              size: 15,
                            )),
                      ),
                      gapW8,
                      const Text(
                        "0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      gapW8,
                      CircleAvatar(
                        radius: 15,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 15,
                            )),
                      ),
                    ],
                  );
                }),
              ),
            );
          }),
    );
  }
}
