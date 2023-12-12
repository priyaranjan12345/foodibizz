import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/notifiers/add_update_iten_notifier.dart';
import 'package:foodibizz/src/features/dashboard/controller/states/add_update_item_state.dart';

final addUpdateItemProvider =
    AutoDisposeAsyncNotifierProvider<AddUpdateItemNotifier, AddUpdateItemState>(
  () => AddUpdateItemNotifier(),
  name: "addUpdateRecipeProvider",
);
