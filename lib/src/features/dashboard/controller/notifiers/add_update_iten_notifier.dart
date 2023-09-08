import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/states/add_update_item_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repository/add_update_recipe/add_update_item_repository_pod.dart';

class AddUpdateItemNotifier extends AutoDisposeNotifier<AddUpdateItemState> {
  @override
  AddUpdateItemState build() {
    return AddUpdateItemInitial();
  }

  Future<void> addRecipe({
    required XFile img,
    required String name,
    required String desc,
    required double price,
  }) async {
    state = AddUpdateItemLoading();
    final result = await ref.watch(addUpdateItemRepositoryProvider).addItem(
          name: name,
          desc: desc,
          price: price,
          dateTime: DateTime.now().toString(),
          image: File(img.path),
        );

    result.when(
      (foodItem) {
        state = AddUpdateItemLoaded();
      },
      (error) {
        state = AddUpdateItemError(message: error.message);
      },
    );
  }

  Future<void> updateRecipe({
    required XFile img,
    required String name,
    required String desc,
    required double price,
  }) async {}
}
