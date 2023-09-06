import 'package:dio/dio.dart';

abstract class IAddUpdateRecipeApi {
  Future<Response> addupdateRecipe({CancelToken? cancelToken});
}
