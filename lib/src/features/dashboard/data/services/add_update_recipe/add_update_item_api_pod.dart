import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/data/services/add_update_recipe/add_update_item_api.dart';
import 'package:foodibizz/src/features/dashboard/data/services/add_update_recipe/i_add_update_item_api.dart';

import '../../../../../../global/api_client/dio_client_pod.dart';

final addUpdateItemApiProvider = Provider.autoDispose<IAddUpdateItemApi>(
  (ref) => AddUpdateItemApi(
    dio: ref.watch(dioProvider),
  ),
);
