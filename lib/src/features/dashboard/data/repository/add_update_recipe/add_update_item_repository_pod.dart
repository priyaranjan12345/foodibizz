import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../apis/add_update_recipe/add_update_item_api_pod.dart';
import 'add_update_item_repository.dart';
import 'i_add_update_item_repository.dart';

final addUpdateItemRepositoryProvider =
    Provider.autoDispose<IAddUpdateItemRepository>(
  (ref) => AddUpdateItemRepository(
    iAddUpdateItemApi: ref.watch(addUpdateItemApiProvider),
  ),
);
