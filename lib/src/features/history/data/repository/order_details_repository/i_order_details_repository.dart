import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../../global/exceptions/base_exception.dart';
import '../../../model/order_details_reponse.dart';

abstract class IOrderDetailsRepository {
  Future<Result<OrderDetailsResponse, BaseException>> getOrderDetails({
    required int orderId,
    CancelToken? cancelToken,
  });
}
