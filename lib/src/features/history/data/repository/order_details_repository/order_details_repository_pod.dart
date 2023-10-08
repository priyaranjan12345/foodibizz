
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../apis/order_details_api/order_details_api_pod.dart';
import 'i_order_details_repository.dart';
import 'order_details_repository.dart';

final orderDetailsRepoProvider = Provider.autoDispose<IOrderDetailsRepository>(
  (ref) => OrderDetailsRepository(
    iOrderDetailsApi: ref.watch(orderDetailsApiProvider),
  ),
  name: "orderDetailsRepoProvider",
);