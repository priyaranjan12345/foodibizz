import 'package:dio/dio.dart';
import 'package:foodibizz/global/exceptions/api_exception.dart';

import 'package:foodibizz/global/exceptions/no_internet_exception.dart';
import 'package:foodibizz/global/extensions/response_hadler_ext.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/dashboard/i_dashboard_api.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/dashboard/i_dashboard_repository.dart';
import 'package:foodibizz/src/features/dashboard/model/all_food_items_response.dart';
import 'package:foodibizz/src/features/dashboard/model/delete_model.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:foodibizz/global/exceptions/base_exception.dart';


class DashboardRepository extends IDashboardRepository {
  final IDashboardApi iDashboardApi;
  DashboardRepository({required this.iDashboardApi});

  @override
  Future<Result<AllFoodItemResponse, BaseException>> getAllItems({
    CancelToken? cancelToken,
  }) async {
    final response = await iDashboardApi.getAllItems(cancelToken: cancelToken);

    if (response.statusCode == 200) {
      try {
        return Success(AllFoodItemResponse.fromMap(response.data));
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

  @override
  Future<Result<DeleteModel, APIException>> deleteItems({
    required String id,
    CancelToken? cancelToken,
  }) async {
    final response = await iDashboardApi.deleteItems(
      id: id,
      cancelToken: cancelToken,
    );

    return response.successErrorHandler(
      successMapper: (result) => DeleteModel.fromMap(
        {"message": "Delete success"},
      ),
    );
  }
}
