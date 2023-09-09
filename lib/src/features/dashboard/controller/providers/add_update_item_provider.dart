import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/add_update_iten_notifier.dart';
import '../states/add_update_item_state.dart';

final addUpdateItemProvider = AutoDisposeAsyncNotifierProvider<
    AddUpdateItemNotifier, AddUpdateItemState>(
  () => AddUpdateItemNotifier(),
  name: "addUpdateRecipeProvider",
);
