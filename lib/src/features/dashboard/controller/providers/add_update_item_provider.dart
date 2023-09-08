import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/states/add_update_item_state.dart';

import '../notifiers/add_update_iten_notifier.dart';

final addUpdateItemProvider =
    AutoDisposeNotifierProvider<AddUpdateItemNotifier, AddUpdateItemState>(
  () => AddUpdateItemNotifier(),
  name: "addUpdateRecipeProvider",
);
