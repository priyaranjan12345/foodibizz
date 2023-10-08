import 'package:dio/dio.dart';

import 'i_order_details_api.dart';

class OrderDetailsApi implements IOrderDetailsApi {
  final Dio dio;
  OrderDetailsApi({required this.dio});

  @override
  Future<Response> getOrderDetailsById({
    required int orderId,
    CancelToken? cancelToken,
  }) {
    return dio.get(
      'sold/all-solditems/$orderId',
      cancelToken: cancelToken,
    );
  }
}
