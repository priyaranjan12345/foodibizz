import 'package:dio/dio.dart';
import 'package:foodibizz/data/model/dashboard_model/all_food_items_response.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IDashboardRepository {
  Future<Result<AllFoodItemResponse, BaseException>> getAllItems({CancelToken? cancelToken});
}
