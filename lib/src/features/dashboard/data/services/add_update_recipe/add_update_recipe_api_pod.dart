import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/data/services/add_update_recipe/add_update_recipe_api.dart';
import 'package:foodibizz/src/features/dashboard/data/services/add_update_recipe/i_add_update_recipe_api.dart';

import '../../../../../../global/api_client/dio_client_pod.dart';

final dashboardApiProvider = Provider.autoDispose<IAddUpdateRecipeApi>(
  (ref) => AddUpdateRecipeApi(
    dio: ref.watch(dioProvider),
  ),
);
