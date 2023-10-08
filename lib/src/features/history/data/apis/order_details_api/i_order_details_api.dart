import 'package:dio/dio.dart';

abstract class IOrderDetailsApi {
  Future<Response> getOrderDetailsById({
    required int orderId,
    CancelToken? cancelToken,
  });
}
