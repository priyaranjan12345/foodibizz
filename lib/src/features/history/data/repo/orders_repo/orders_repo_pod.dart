import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/history/data/apis/orders/orders_api_pod.dart';
import 'package:foodibizz/src/features/history/data/repo/orders_repo/i_orders_repo.dart';
import 'package:foodibizz/src/features/history/data/repo/orders_repo/orders_repo.dart';

final ordersRepoProvider = Provider.autoDispose<IOrdersRepo>(
    (ref) => OrdersRepo(iOrdersApi: ref.watch(ordersApiProvider)));
