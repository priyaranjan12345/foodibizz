import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repository/add_update_recipe/add_update_item_repository_pod.dart';
import '../states/addupdate_item_state.dart';

class AddUpdateItemNotifier
    extends AutoDisposeAsyncNotifier<AddUpdateItemState> {
  @override
  FutureOr<AddUpdateItemState> build() {
    state = AsyncData(AddUpdateItemInitial());
    return future;
  }

  Future<void> addRecipe({
    required XFile img,
    required String name,
    required String desc,
    required double price,
  }) async {
    state = const AsyncLoading();
    final result = await ref.watch(addUpdateItemRepositoryProvider).addItem(
          name: name,
          desc: desc,
          price: price,
          dateTime: DateTime.now().toString(),
          image: File(img.path),
        );

    result.when(
      (foodItem) {
        state = AsyncData(AddUpdateItemLoaded());
      },
      (error) {
        state = AsyncError(error, StackTrace.current);
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
