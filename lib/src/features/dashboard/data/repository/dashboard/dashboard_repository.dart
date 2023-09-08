import 'package:dio/dio.dart';

import 'package:foodibizz/global/exceptions/no_internet_exception.dart';
import 'package:foodibizz/src/features/dashboard/data/services/dashboard/i_dashboard_api.dart';
import 'package:foodibizz/src/features/dashboard/model/all_food_items_response.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'i_dashboard_repository.dart';

class DashboardRepository extends IDashboardRepository {
  final IDashboardApi iDashboardApi;
  DashboardRepository({required this.iDashboardApi});

  @override
  Future<Result<AllFoodItemResponse, BaseException>> getAllItems({
    CancelToken? cancelToken,
  }) async {
    final response = await iDashboardApi.getAllItems(cancelToken: cancelToken);

    if (response.statusCode == 200 || response.statusCode == 201) {
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
}
