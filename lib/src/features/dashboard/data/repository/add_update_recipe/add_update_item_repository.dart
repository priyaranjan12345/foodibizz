import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/src/features/dashboard/model/all_food_items_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../../global/exceptions/no_internet_exception.dart';
import '../../apis/add_update_recipe/i_add_update_item_api.dart';
import 'i_add_update_item_repository.dart';

class AddUpdateItemRepository implements IAddUpdateItemRepository {
  final IAddUpdateItemApi iAddUpdateItemApi;
  AddUpdateItemRepository({required this.iAddUpdateItemApi});

  @override
  Future<Result<FoodItem, BaseException>> addItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
    CancelToken? cancelToken,
  }) async {
    var response = await iAddUpdateItemApi.addItem(
      name: name,
      desc: desc,
      price: price,
      dateTime: dateTime,
      image: image,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return Success(FoodItem.fromMap(response.data));
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
  Future<Result<String, BaseException>> updateItem({
    required int id,
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    File? image,
    CancelToken? cancelToken,
  }) async {
    var response = await iAddUpdateItemApi.updateItem(
      id: id,
      name: name,
      desc: desc,
      price: price,
      dateTime: dateTime,
      image: image,
    );
    if (response.statusCode == 202) {
      try {
        return const Success("Item updated successfully");
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
