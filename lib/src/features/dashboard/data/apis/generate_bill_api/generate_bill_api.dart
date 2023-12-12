import 'package:dio/dio.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/generate_bill_api/i_generate_bill_api.dart';
import 'package:foodibizz/src/features/dashboard/model/add_sold_item_model.dart';



class GenerateBillApi extends IGenerateBillApi {
  final Dio dio;
  GenerateBillApi({required this.dio});

  @override
  Future<Response> createOrder({
    required String dateTime,
    required String invNo,
    required int noOfItems,
    required double gst,
    required double discount,
    required double grandTotal,
  }) async {
    var payload = {
      "id": 0,
      "billingDate": dateTime,
      "invNum": invNo,
      "noOfItems": noOfItems,
      "discount": discount,
      "gst": gst,
      "grandTotal": grandTotal,
    };

    return await dio.post(
      'Order/add-order',
      data: payload,
    );
  }

  @override
  Future<Response> saveBillItems({
    required AddSoldItemModel addSoldItemModel,
  }) async {
    var payload = addSoldItemModel.toMap();

    return await dio.post(
      'sold/add-solditem',
      data: payload,
    );
  }
}
