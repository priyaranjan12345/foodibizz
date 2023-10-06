import 'package:dio/dio.dart';
import 'package:foodibizz/src/features/history/data/apis/orders/i_orders_api.dart';

class OrdersApi extends IOrdersApi {
  final Dio dio;
  OrdersApi({required this.dio});
  @override
  Future<Response> getAllOrders({CancelToken? cancelToken}) async {
    return await dio.get("Order/all-orders", cancelToken: cancelToken);
  }
}
