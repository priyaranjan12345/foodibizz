import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/add_update_recipe/add_update_item_api_pod.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/add_update_recipe/add_update_item_repository.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/add_update_recipe/i_add_update_item_repository.dart';


final addUpdateItemRepositoryProvider =
    Provider.autoDispose<IAddUpdateItemRepository>(
  (ref) => AddUpdateItemRepository(
    iAddUpdateItemApi: ref.watch(addUpdateItemApiProvider),
  ),
);
