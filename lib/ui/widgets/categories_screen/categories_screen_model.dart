import 'package:flutter/material.dart';
import 'package:recipes/domain/factories/screen_factory.dart';

class CategoriesScreenModel {
final _screenFactory = ScreenFactory();


  void onCategoryTap(BuildContext context ,String category) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => _screenFactory.makeFilterScreen(category, null)));
  }
}