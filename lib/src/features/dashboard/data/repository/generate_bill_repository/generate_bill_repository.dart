import 'package:foodibizz/global/exceptions/base_exception.dart';
import 'package:foodibizz/global/exceptions/no_internet_exception.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/generate_bill_api/i_generate_bill_api.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/generate_bill_repository/i_generate_bill_repository.dart';
import 'package:foodibizz/src/features/dashboard/model/add_order_model.dart';
import 'package:foodibizz/src/features/dashboard/model/add_sold_item_model.dart';
import 'package:multiple_result/multiple_result.dart';



class GenerateBillRepository implements IGenerateBillRepository {
  final IGenerateBillApi iGenerateBillApi;
  GenerateBillRepository({required this.iGenerateBillApi});

  @override
  Future<Result<AddOrderModel, BaseException>> createOrder({
    required String dateTime,
    required String invNo,
    required int noOfItems,
    required double gst,
    required double discount,
    required double grandTotal,
  }) async {
    final response = await iGenerateBillApi.createOrder(
      dateTime: dateTime,
      invNo: invNo,
      noOfItems: noOfItems,
      gst: gst,
      discount: discount,
      grandTotal: grandTotal,
    );

    if (response.statusCode == 201) {
      try {
        return Success(AddOrderModel.fromMap(response.data));
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
  Future<Result<AddSoldItemModel, BaseException>> saveBillItems({
    required AddSoldItemModel addSoldItemModel,
  }) async {
    final response = await iGenerateBillApi.saveBillItems(
      addSoldItemModel: addSoldItemModel,
    );

    if (response.statusCode == 201) {
      try {
        return Success(AddSoldItemModel.fromMap(response.data));
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
