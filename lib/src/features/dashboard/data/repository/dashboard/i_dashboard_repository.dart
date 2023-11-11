import 'package:dio/dio.dart';
import 'package:foodibizz/global/exceptions/api_exception.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/src/features/dashboard/model/all_food_items_response.dart';
import 'package:foodibizz/src/features/dashboard/model/delete_model.dart';
import 'package:multiple_result/multiple_result.dart';



abstract class IDashboardRepository {
  Future<Result<AllFoodItemResponse, BaseException>> getAllItems({
    CancelToken? cancelToken,
  });

  Future<Result<DeleteModel, APIException>> deleteItems({
    required String id,
    CancelToken? cancelToken,
  });
}
