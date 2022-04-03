import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/ui/widgets/categories_screen/categories_screen_model.dart';

import 'package:recipes/ui/widgets/elements/elements.dart';

class CategoriesScreenWidget extends StatelessWidget {
  CategoriesScreenWidget({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {'name': 'Beef', 'url': 'assets/images/beed.jpg'},
    {'name': 'Breakfast', 'url': 'assets/images/breakfast.jpg'},
    {'name': 'Chicken', 'url': 'assets/images/chicken.jpg'},
    {'name': 'Dessert', 'url': 'assets/images/dessert.png'},
    {'name': 'Goat', 'url': 'assets/images/goat.jpg'},
    {'name': 'Lamb', 'url': 'assets/images/lamb.jpg'},
    {'name': 'Miscellaneous', 'url': 'assets/images/diverse.jpg'},
    {'name': 'Pasta', 'url': 'assets/images/pasta.jpg'},
    {'name': 'Pork', 'url': 'assets/images/pork.jpg'},
    {'name': 'Seafood', 'url': 'assets/images/seafood.jpg'},
    {'name': 'Side', 'url': 'assets/images/side.jpg'},
    {'name': 'Starter', 'url': 'assets/images/starter.jpg'},
    {'name': 'Vegan', 'url': 'assets/images/vegan.jpg'},
    {'name': 'Vegetarian', 'url': 'assets/images/vegetarian.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.read<CategoriesScreenModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                    size: 24, text: 'Select category', isBold: FontWeight.bold),
                const SizedBox(height: 15),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => model.onCategoryTap(
                          context, categories[index]['name']),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 26,
                        height: 215,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.8),
                          image: DecorationImage(
                            image: AssetImage(categories[index]['url']),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: Center(
                          child: AppText(
                            size: 30,
                            // isBold: FontWeight.bold,
                            text: index != 6
                                ? categories[index]['name']
                                : 'Diverse',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
