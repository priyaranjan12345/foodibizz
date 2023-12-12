import 'package:dio/dio.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/src/features/history/model/order_details_reponse.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IOrderDetailsRepository {
  Future<Result<OrderDetailsResponse, BaseException>> getOrderDetails({
    required int orderId,
    CancelToken? cancelToken,
  });
}
