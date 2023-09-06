import 'package:dio/dio.dart';
import 'package:foodibizz/src/features/dashboard/data/services/add_update_recipe/i_add_update_recipe_api.dart';

class AddUpdateRecipeApi extends IAddUpdateRecipeApi {
  final Dio dio;
  AddUpdateRecipeApi({required this.dio});

  @override
  Future<Response> addupdateRecipe({CancelToken? cancelToken}) async {
    return await dio.get(
      'item/add-fooditem',
      cancelToken: cancelToken,
    );
  }
}
