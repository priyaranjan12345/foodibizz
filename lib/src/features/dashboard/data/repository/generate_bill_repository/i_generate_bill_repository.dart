import 'package:multiple_result/multiple_result.dart';

import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/src/features/dashboard/model/add_order_model.dart';
import 'package:foodibizz/src/features/dashboard/model/add_sold_item_model.dart';




abstract class IGenerateBillRepository {
    Future<Result<AddOrderModel, BaseException>> createOrder({
    required String dateTime,
    required String invNo,
    required int noOfItems,
    required double gst,
    required double discount,
    required double grandTotal,
  });
  Future<Result<AddSoldItemModel, BaseException>> saveBillItems({
    required AddSoldItemModel addSoldItemModel,
  });
}
