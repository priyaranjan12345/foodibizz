import 'package:dio/dio.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/src/features/history/model/all_orders_reponse.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IOrdersRepo {
  Future<Result<AllOrdersResponse, BaseException>> getAllOrders({
    CancelToken? cancelToken,
  });
}
