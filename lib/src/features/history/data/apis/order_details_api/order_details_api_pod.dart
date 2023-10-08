import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../global/api_client/dio_client_pod.dart';
import 'i_order_details_api.dart';
import 'order_details_api.dart';

final orderDetailsApiProvider = Provider.autoDispose<IOrderDetailsApi>(
  (ref) => OrderDetailsApi(
    dio: ref.watch(dioProvider),
  ),
  name: "orderDetailsApiProvider",
);
