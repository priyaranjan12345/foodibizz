import 'dart:io';

import 'package:dio/dio.dart';

abstract class IAddUpdateItemApi {
  Future<Response> addItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
    CancelToken? cancelToken,
  });

  Future<Response> updateItem({
    required int id,
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    File? image,
    CancelToken? cancelToken,
  });
}
