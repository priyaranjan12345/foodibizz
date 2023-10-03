import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/add_update_recipe/add_update_item_repository_pod.dart';
import '../states/add_update_item_state.dart';

class AddUpdateItemNotifier
    extends AutoDisposeAsyncNotifier<AddUpdateItemState> {
  @override
  FutureOr<AddUpdateItemState> build() {
    state = const AsyncData(AddUpdateItemInitial());
    return future;
  }

  Future<void> addRecipe({
    required File img,
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
          image: img,
        );

    result.when(
      (foodItem) {
        state = const AsyncData(AddUpdateItemLoaded());
      },
      (error) {
        state = AsyncError(error.message, StackTrace.current);
      },
    );
  }

  Future<void> updateRecipe({
    File? img,
    required String name,
    required String desc,
    required double price,
  }) async {
    state = const AsyncLoading();
    final result = await ref.watch(addUpdateItemRepositoryProvider).updateItem(
          name: name,
          desc: desc,
          price: price,
          dateTime: DateTime.now().toString(),
          image: img,
        );

    result.when(
      (foodItem) {
        state = const AsyncData(AddUpdateItemLoaded());
      },
      (error) {
        state = AsyncError(error.message, StackTrace.current);
      },
    );
  }
}
