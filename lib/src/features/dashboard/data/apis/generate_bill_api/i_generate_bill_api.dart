import 'package:dio/dio.dart';

import '../../../model/add_sold_item_model.dart';

abstract class IGenerateBillApi {
  Future<Response> createOrder({
    required String dateTime,
    required String invNo,
    required int noOfItems,
    required double gst,
    required double discount,
    required double grandTotal,
  });
  Future<Response> saveBillItems({
    required AddSoldItemModel addSoldItemModel,
  });
}
