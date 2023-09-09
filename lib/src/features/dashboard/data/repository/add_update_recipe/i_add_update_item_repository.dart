import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/src/features/dashboard/model/all_food_items_response.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IAddUpdateItemRepository {
  Future<Result<FoodItem, BaseException>> addItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
    CancelToken? cancelToken,
  });
}
