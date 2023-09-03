import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/data/model/dashboard_model/all_food_items_response.dart';
import 'package:foodibizz/data/repository/dashboard/dashboard_repository_pod.dart';

final dashboardProvider = FutureProvider.autoDispose<AllFoodItemResponse>(
  (ref) async {
    final result = await ref.watch(dashboardRepositoryProvider).getAllItems();

    return result.when(
      (allFoodItems) {
        return allFoodItems;
      },
      (error) {
        throw error;
      },
    );
  },
  name: "dashboardProvider",
);
