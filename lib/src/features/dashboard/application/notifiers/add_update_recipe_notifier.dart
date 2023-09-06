import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/application/states/add_update_recipe_state.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdateRecipeNotifier
    extends AutoDisposeAsyncNotifier<AddUpdateRecipeState> {
  @override
  FutureOr<AddUpdateRecipeState> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> addRecipe(
      {required XFile img,
      required String name,
      required String desc,
      required int price}) async {}
      
  Future<void> updateRecipe(
      {required XFile img,
      required String name,
      required String desc,
      required int price}) async {}
}
