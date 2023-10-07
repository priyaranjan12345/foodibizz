import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/history/data/apis/orders_api/orders_api_pod.dart';
import 'package:foodibizz/src/features/history/data/repository/orders_repository/i_orders_repository.dart';
import 'package:foodibizz/src/features/history/data/repository/orders_repository/orders_repository.dart';

final ordersRepoProvider = Provider.autoDispose<IOrdersRepo>(
  (ref) => OrdersRepo(
    iOrdersApi: ref.watch(ordersApiProvider),
  ),
  name: "ordersRepoProvider",
);
