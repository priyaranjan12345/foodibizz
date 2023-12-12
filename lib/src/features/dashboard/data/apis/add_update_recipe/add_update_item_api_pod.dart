import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/api_client/dio_client_pod.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/add_update_recipe/add_update_item_api.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/add_update_recipe/i_add_update_item_api.dart';



final addUpdateItemApiProvider = Provider.autoDispose<IAddUpdateItemApi>(
  (ref) => AddUpdateItemApi(
    dio: ref.watch(dioProvider),
  ),
);
