import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodibizz/global/riverpod_ext/cache_ext.dart';
import 'package:foodibizz/global/riverpod_ext/cancel_ext.dart';
import 'package:foodibizz/src/features/history/data/repository/order_details_repository/order_details_repository_pod.dart';
import 'package:foodibizz/src/features/history/model/order_details_reponse.dart';



final orderDetailsProvider =
    FutureProvider.family.autoDispose<OrderDetailsResponse, int>(
  (ref, id) async {
    final token = ref.cancelToken();
    final link = ref.cacheFor();
    final result = await ref.watch(orderDetailsRepoProvider).getOrderDetails(
          cancelToken: token,
          orderId: id,
        );

    return result.when((success) {
      return success;
    }, (error) {
      link.close();
      throw error;
    });
  },
  name: "allOrdersProvider",
);
