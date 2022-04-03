import 'package:flutter/cupertino.dart';
import 'package:recipes/domain/entity/recipe_details.dart';
import 'package:recipes/domain/services/recipe_service.dart';

class DetailsScreenModel extends ChangeNotifier {
  final _recipeService = RecipeService();
  RecipeDetails? _details;

  final String id;
  var _products = [];

  RecipeDetails? get recipe => _details;
  List get products => _products;

  DetailsScreenModel({required this.id}) {
    _loadRecipe(id);
  }

  Future<void> _loadRecipe(String id) async {
    _details = await _recipeService.getDetails(id);
    _products.addAll([
      {
        'name': _details?.meals![0].strIngredient1,
        'weight': _details?.meals![0].strMeasure1,
      },
      {
        'name': _details?.meals![0].strIngredient2,
        'weight': _details?.meals![0].strMeasure2,
      },
      {
        'name': _details?.meals![0].strIngredient3,
        'weight': _details?.meals![0].strMeasure3,
      },
      {
        'name': _details?.meals![0].strIngredient4,
        'weight': _details?.meals![0].strMeasure4,
      },
      {
        'name': _details?.meals![0].strIngredient5,
        'weight': _details?.meals![0].strMeasure5,
      },
      {
        'name': _details?.meals![0].strIngredient6,
        'weight': _details?.meals![0].strMeasure6,
      },
      {
        'name': _details?.meals![0].strIngredient7,
        'weight': _details?.meals![0].strMeasure7,
      },
    ]);
    notifyListeners();
  }
}
