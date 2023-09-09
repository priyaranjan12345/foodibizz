import 'package:dio/dio.dart';
import 'i_dashboard_api.dart';

class DashboardApi extends IDashboardApi {
  final Dio dio;
  DashboardApi({required this.dio});

  @override
  Future<Response> getAllItems({
    CancelToken? cancelToken,
  }) async {
    return await dio.get(
      'item/all-fooditems',
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> deleteItems({
    required String id,
    CancelToken? cancelToken,
  }) async {
    return await dio.delete('/item/delete-fooditem/$id');
  }
}
