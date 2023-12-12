import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/api_client/dio_client_pod.dart';
import 'package:foodibizz/src/features/history/data/apis/order_details_api/i_order_details_api.dart';
import 'package:foodibizz/src/features/history/data/apis/order_details_api/order_details_api.dart';

final orderDetailsApiProvider = Provider.autoDispose<IOrderDetailsApi>(
  (ref) => OrderDetailsApi(
    dio: ref.watch(dioProvider),
  ),
  name: "orderDetailsApiProvider",
);
