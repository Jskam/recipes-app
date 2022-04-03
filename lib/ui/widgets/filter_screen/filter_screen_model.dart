import 'package:flutter/material.dart';
import 'package:recipes/domain/entity/recipe_category.dart';
import 'package:recipes/domain/factories/screen_factory.dart';
import 'package:recipes/domain/services/recipe_service.dart';

class FilterScreenModel extends ChangeNotifier {
  final _screenFactory = ScreenFactory();

  final _recipeService = RecipeService();
  RecipeCategory? response;
  bool? isCategory;

  String? category;
  String? country;

  FilterScreenModel({this.category, this.country}) {
    if (country == null && category != null) {
      _getCategoryResponse();
    } else if (category == null && country != null) {
      _getCountryResponse();
    } else {
      print('Какая-то ошибка в Filter Screen Model #########');
    }
  }

  Future<void> _getCountryResponse() async {
    response = await _recipeService.getAreaRecipes(country!);
    isCategory = false;
    notifyListeners();
  }

  Future<void> _getCategoryResponse() async {
    response = await _recipeService.getCategoryRecipes(category!);
    isCategory = true;
    notifyListeners();
  }

  Future<void> onRecipeTap(BuildContext context, String id) async {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => _screenFactory.makeDetailsScreen(id)));
  }
}
