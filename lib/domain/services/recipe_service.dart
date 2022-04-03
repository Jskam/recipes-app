import 'package:recipes/domain/api/api_client.dart';
import 'package:recipes/domain/entity/recipe_category.dart';
import 'package:recipes/domain/entity/recipe_details.dart';

class RecipeService {
  final _apiClient = ApiClient();

  Future<RecipeCategory> getCategoryRecipes(String category) async {
    return await _apiClient.getCategoryRecipes(category);
  }

  Future<RecipeCategory> getAreaRecipes(String area) async {
    return await _apiClient.getAreaRecipes(area);
  }

  Future<RecipeDetails> getDetails(String id) async {
    return await _apiClient.getDetails(id);
  }
}
