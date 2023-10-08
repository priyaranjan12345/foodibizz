import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/riverpod_ext/cache_ext.dart';
import 'package:foodibizz/global/riverpod_ext/cancel_ext.dart';
import 'package:foodibizz/src/features/history/data/repository/orders_repository/orders_repository_pod.dart';
import 'package:foodibizz/src/features/history/model/all_orders_reponse.dart';

final allOrdersProvider = FutureProvider.autoDispose<AllOrders>(
  (ref) async {
    final token = ref.cancelToken();
    final link = ref.cacheFor();
    final result =
        await ref.watch(ordersRepoProvider).getAllOrders(cancelToken: token);

    return result.when((success) {
      return success;
    }, (error) {
      link.close();
      throw error;
    });
  },
  name: "allOrdersProvider",
);
