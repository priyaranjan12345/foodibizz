import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/api_client/dio_client_pod.dart';
import 'package:foodibizz/src/features/history/data/apis/orders_api/i_orders_api.dart';
import 'package:foodibizz/src/features/history/data/apis/orders_api/orders_api.dart';

final ordersApiProvider = Provider.autoDispose<IOrdersApi>(
  (ref) => OrdersApi(
    dio: ref.watch(dioProvider),
  ),
  name: "ordersApiProvider",
);
