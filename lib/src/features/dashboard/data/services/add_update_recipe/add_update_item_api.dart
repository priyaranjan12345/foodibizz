import 'dart:io';

import 'package:dio/dio.dart';
import 'i_add_update_item_api.dart';

class AddUpdateItemApi extends IAddUpdateItemApi {
  final Dio dio;
  AddUpdateItemApi({required this.dio});

  @override
  Future<Response> addItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
    CancelToken? cancelToken,
  }) async {
    var formData = FormData.fromMap({
      'name': name,
      'desc': desc,
      'price': price,
      'creationDate': dateTime,
      if (image != null) 'foodImage': await MultipartFile.fromFile(image.path)
    });

    return await dio.post(
      'item/add-fooditem',
      data: formData,
    );
  }
}
