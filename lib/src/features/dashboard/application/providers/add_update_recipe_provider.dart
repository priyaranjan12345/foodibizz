import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/application/states/add_update_recipe_state.dart';

import '../notifiers/add_update_recipe_notifier.dart';

final addUpdateRecipeProvider = AutoDisposeAsyncNotifierProvider<
    AddUpdateRecipeNotifier,
    AddUpdateRecipeState>(() => AddUpdateRecipeNotifier());
