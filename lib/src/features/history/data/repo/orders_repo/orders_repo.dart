import 'package:flutter/material.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/src/features/history/data/apis/orders/i_orders_api.dart';
import 'package:foodibizz/src/features/history/data/repo/orders_repo/i_orders_repo.dart';
import 'package:foodibizz/src/features/history/model/all_orders_reponse.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:dio/dio.dart';
import '../../../../../../global/exceptions/no_internet_exception.dart';

class OrdersRepo extends IOrdersRepo {
  final IOrdersApi iOrdersApi;
  OrdersRepo({required this.iOrdersApi});
  @override
  Future<Result<AllOrdersResponse, BaseException>> getAllOrders(
      {CancelToken? cancelToken}) async {
    final response = await iOrdersApi.getAllOrders(cancelToken: cancelToken);
    print("print the respone==== ${response.data}");
    if (response.statusCode == 200) {
      try {
        return Success(AllOrdersResponse.fromJson(response.toString()));
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
