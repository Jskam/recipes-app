import 'dart:convert';
import 'dart:io';

import 'package:recipes/domain/entity/recipe_category.dart';
import 'package:recipes/domain/entity/recipe_details.dart';

class ApiClient {
  final client = HttpClient();

  Future<dynamic> _get(String path) async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/$path');
    final request = await client.getUrl(url);
    final response = await request.close();
    return await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((val) => jsonDecode(val));
  }

  Future<RecipeCategory> getCategoryRecipes(String category) async {
    final json = await _get('filter.php?c=$category');
    return RecipeCategory.fromJson(json);
  }

  Future<RecipeCategory> getAreaRecipes(String area) async {
    final json = await _get('filter.php?a=$area');
    return RecipeCategory.fromJson(json);
  }

  Future<RecipeDetails> getDetails(String id) async {
    final json = await _get('lookup.php?i=$id');
    return RecipeDetails.fromJson(json);
  }
}
