import 'package:dio/dio.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/global/exceptions/no_internet_exception.dart';
import 'package:foodibizz/src/features/history/data/apis/order_details_api/i_order_details_api.dart';
import 'package:foodibizz/src/features/history/data/repository/order_details_repository/i_order_details_repository.dart';
import 'package:foodibizz/src/features/history/model/order_details_reponse.dart';
import 'package:multiple_result/multiple_result.dart';



class OrderDetailsRepository implements IOrderDetailsRepository {
  final IOrderDetailsApi iOrderDetailsApi;
  OrderDetailsRepository({required this.iOrderDetailsApi});

  @override
  Future<Result<OrderDetailsResponse, BaseException>> getOrderDetails({
    required int orderId,
    CancelToken? cancelToken,
  }) async {
    final response = await iOrderDetailsApi.getOrderDetailsById(
      orderId: orderId,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      try {
        return Success(OrderDetailsResponse.fromMap(response.data));
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else if (response.statusCode == 401) {
      return Error(BaseException(message: response.data.toString()));
    } else {
      final details = response.data['message'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details.toString()));
      }
    }
  }
}
