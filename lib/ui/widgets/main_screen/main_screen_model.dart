import 'package:flutter/material.dart';
import 'package:recipes/domain/entity/recipe_category.dart';
import 'package:recipes/domain/factories/screen_factory.dart';
import 'package:recipes/domain/services/recipe_service.dart';

class MainScreenModel extends ChangeNotifier {
  final _screenFactory = ScreenFactory();
  final _recipeService = RecipeService();
  RecipeCategory? _populars;

  List<Meals>? get populars => _populars?.meals;

  MainScreenModel() {
    _getPopular();
  }

  Future<void> _getPopular() async {
    _populars = await _recipeService.getCategoryRecipes('Beef');
    notifyListeners();
  }

  void onCountryTap(BuildContext context, String country) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => _screenFactory.makeFilterScreen(null, country)));
  }

  void onRecipeTap(BuildContext context, String id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => _screenFactory.makeDetailsScreen(id)));
  }
}
