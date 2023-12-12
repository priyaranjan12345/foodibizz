import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodibizz/src/features/history/data/apis/order_details_api/order_details_api_pod.dart';
import 'package:foodibizz/src/features/history/data/repository/order_details_repository/i_order_details_repository.dart';
import 'package:foodibizz/src/features/history/data/repository/order_details_repository/order_details_repository.dart';

final orderDetailsRepoProvider = Provider.autoDispose<IOrderDetailsRepository>(
  (ref) => OrderDetailsRepository(
    iOrderDetailsApi: ref.watch(orderDetailsApiProvider),
  ),
  name: "orderDetailsRepoProvider",
);