import 'package:dio/dio.dart';

abstract class IDashboardApi {
  Future<Response> getAllItems({
    CancelToken? cancelToken,
  });
  Future<Response> deleteItems({
    required String id,
    CancelToken? cancelToken,
  });
}
