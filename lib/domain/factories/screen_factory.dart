import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/ui/widgets/categories_screen/categories_screen_model.dart';
import 'package:recipes/ui/widgets/categories_screen/categories_screen_widget.dart';
import 'package:recipes/ui/widgets/details_screen/details_screen_model.dart';
import 'package:recipes/ui/widgets/details_screen/details_screen_widget.dart';
import 'package:recipes/ui/widgets/favorite_screen/favorite_screen_model.dart';
import 'package:recipes/ui/widgets/favorite_screen/favorite_screen_widget.dart';
import 'package:recipes/ui/widgets/filter_screen/filter_screen_model.dart';
import 'package:recipes/ui/widgets/filter_screen/filter_screen_widget.dart';
import 'package:recipes/ui/widgets/main_screen/main_screen_model.dart';
import 'package:recipes/ui/widgets/main_screen/main_screen_widget.dart';

class ScreenFactory{

Widget makeMainScreen() {
    return ChangeNotifierProvider(
      create: (_) => MainScreenModel(),
      child:  const MainScreenWidget(),
      lazy: false,
    );
  }

  Widget makeCategoriesScreen() {
    return Provider(
      create: (_) => CategoriesScreenModel(),
      child:  CategoriesScreenWidget(),
    );
  }

  Widget makeFavoriteScreen() {
    return ChangeNotifierProvider(
      create: (_) => FavoriteScreenModel(),
      child: const FavoriteScreenWidget(),
    );
  }

  Widget makeFilterScreen(String? category, String? country) {
    return ChangeNotifierProvider(
      create: (_) => FilterScreenModel(category: category, country: country),
      child: const FilterScreenWidget(),
    );
  }

  Widget makeDetailsScreen(String id) {
    return ChangeNotifierProvider(
      create: (_) => DetailsScreenModel(id: id),
      child: const DetailsScreenWidget(),
    );
  }

  

}