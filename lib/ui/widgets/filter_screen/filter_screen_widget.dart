import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recipes/ui/widgets/elements/elements.dart';
import 'package:recipes/ui/widgets/filter_screen/filter_screen_model.dart';

class FilterScreenWidget extends StatelessWidget {
  const FilterScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FilterScreenModel>();
    final response = model.response?.meals;
    final String title;
    if (model.isCategory == true && model.category != null) {
      title = model.category!;
    } else if (model.isCategory == false && model.country != null) {
      title ='${ model.country![0].toUpperCase()}${ model.country!.substring(1)}';
    } else {
      title = 'Loading..';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        title: AppText(
            size: 20,
            text: title,
            isBold: FontWeight.bold),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined))
        ],
        elevation: 0,
      ),
      body: response != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  shrinkWrap: true,
                  itemCount: response.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => model.onRecipeTap(context, response[index].idMeal!),
                      child: ProductWidget(
                        imgurl: response[index].strMealThumb,
                        name: response[index].strMeal,
                        rating: 5,
                        time: null,
                      ),
                    );
                  },
                ),
              ),
            )
          : const Center(
              child:  CircularProgressIndicator(),
            ),
    );
  }
}
