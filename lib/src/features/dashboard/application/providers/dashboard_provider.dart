import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/dashboard_repository_pod.dart';
import 'package:foodibizz/global/riverpod_ext/cache_ext.dart';
import 'package:foodibizz/global/riverpod_ext/cancel_ext.dart';
import 'package:foodibizz/src/features/dashboard/model/all_food_items_response.dart';

final dashboardProvider = FutureProvider.autoDispose<AllFoodItemResponse>(
  (ref) async {
    final token = ref.cancelToken();
    final link = ref.cacheFor();
    final result = await ref
        .watch(dashboardRepositoryProvider)
        .getAllItems(cancelToken: token);

    return result.when(
      (allFoodItems) {
        return allFoodItems;
      },
      (error) {
        link.close();
        throw error;
      },
    );
  },
  name: "dashboardProvider",
);
