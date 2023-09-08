import 'package:dio/dio.dart';

abstract class IDashboardApi {
  Future<Response> getAllItems({
    CancelToken? cancelToken,
  });
}
