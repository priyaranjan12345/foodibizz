import 'package:dio/dio.dart';

abstract class IOrdersApi {
  Future<Response> getAllOrders({
    CancelToken? cancelToken,
  });
}
